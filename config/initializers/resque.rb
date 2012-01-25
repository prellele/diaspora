require 'resque'

Resque::Plugins::Timeout.timeout = 300

if !AppConfig.single_process_mode?
  if redis_to_go = ENV["REDISTOGO_URL"]
    uri = URI.parse(redis_to_go)
    Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  elsif AppConfig[:redis_url]
    Resque.redis = Redis.new(:host => AppConfig[:redis_url], :port => 6379)
  end
end

if AppConfig.single_process_mode?
  if Rails.env == 'production'
    puts "WARNING: You are running Diaspora in production without Resque workers turned on.  Please don't do this."
  end
  module Resque
    def enqueue(klass, *args)
      begin 
        klass.send(:perform, *args)
      rescue Exception => e
        Rails.logger.warn(e.message)
        raise e
        nil
      end
    end
  end
end

if AppConfig[:airbrake_api_key].present?
  require 'resque/failure/multiple'
  require 'resque/failure/airbrake'
  require 'resque/failure/redis'
  Resque::Failure::Airbrake.configure do |config|
    config.api_key = AppConfig[:airbrake_api_key]
    config.secure = true
  end
  Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Airbrake]
  Resque::Failure.backend = Resque::Failure::Multiple
end


if AppConfig[:mount_resque_web]
  require 'resque/server'
  require File.join(Rails.root, 'lib/admin_rack')
  Resque::Server.use AdminRack
end
