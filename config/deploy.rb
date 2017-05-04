# config valid only for Capistrano 3.4
lock '3.4.1'

set :application, 'deploy_tester'
set :repo_url, 'git@github.com:AstroYuta/new_deploytest.git'

set :branch, 'master'
set :deploy_to, '/var/www/deploy_tester'
set :scm, :git
set :log_level, :debug
set :pty, true
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :keep_releases, 5
set :bundle_gemfile,  "/Users/yuta/github-working/deploytest/deploy_tester/Gemfile"
set :bundle_flags, "--quiet --binstubs --shebang ruby-local-exec"

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.rb"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end