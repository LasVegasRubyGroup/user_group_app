rails_env = ENV['RAILS_ENV'] || 'production'
root_path = File.expand_path(File.dirname(__FILE__) + '/../')

worker_processes 1
timeout 30
preload_app true

pid "#{root_path}/tmp/pids/unicorn.pid"

listen "#{root_path}/tmp/sockets/unicorn.sock", backlog: 2048

stderr_path "#{root_path}/log/unicorn.stderr.log"
stdout_path "#{root_path}/log/unicorn.stdout.log"

before_fork do |server, worker|
  old_pid = "#{root_path}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
