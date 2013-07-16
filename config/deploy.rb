require "rvm/capistrano"
require "bundler/capistrano"

ssh_options[:forward_agent] = true
set :scm, 'git'
set :scm_user, "deploy"
set :repository,  "git@github.com:U-Play/profiles.git"
set :branch, 'dev'
# set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache

set :application, "profiles.uplaypro.com"
set :deploy_to,"/home/deploy/profiles.git"

set :user, 'deploy'
set :use_sudo, false

server 'profiles.uplaypro.com', :web, :app, :db, :primary => true

# additional settings
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
    desc "reload the database with seed data"
    task :seed do
      run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
end

after 'deploy:update_code', 'deploy:migrate'