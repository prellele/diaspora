num_sidekiq_workers = 2
rails_root = ENV['RAILS_ROOT'] || "/home/lprelle/diaspora"

every 1.day, :at => '1am' do
  num_sidekiq_workers.times do |num|
    command "kill -USR1 $(cat #{rails_root}/pids/sidekiq#{num}.pid)"
  end
end

every 1.day, :at => '1:01 am' do
  num_sidekiq_workers.times do |num|
    command "kill -TERM $(cat #{rails_root}/pids/sidekiq#{num}.pid)"
  end
end
