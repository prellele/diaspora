rails_env = 'production'

# Enable and set these to run the worker as a different user/group
#user  = 'lennart'
#group = 'lennart'

worker_processes 3

## Load the app before spawning workers
preload_app true

# How long to wait before killing an unresponsive worker
timeout 30

pid '/home/lprelle/diaspora/pids/unicorn.pid'
listen '/home/lprelle/diaspora/diaspora.sock', :backlog => 2048

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log" 

# Ruby Enterprise Feature
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end


before_fork do |server, worker|
  # If using preload_app, enable this line
  ActiveRecord::Base.connection.disconnect!

  # disconnect redis if in use
  if !AppConfig.single_process_mode?
    Resque.redis.client.disconnect
  end

  old_pid = '/home/lprelle/diaspora/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  # If using preload_app, enable this line
  ActiveRecord::Base.establish_connection

  # copy pasta from resque.rb because i'm a bad person
  if !AppConfig.single_process_mode?
    Resque.redis = AppConfig.get_redis_instance
  end

  # Enable this line to have the workers run as different user/group
  #worker.user(user, group)
end
