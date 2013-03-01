require "bundler/capistrano"
require 'rvm'
require 'rvm/capistrano'

set :domain, "www.megabookstore.com"
set :application, "megabook"
set :repository,  "ssh://git@bitbucket.org/raeno/rails_study.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true

set :scm, "git"
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

set :deploy_via, :remote_cache

set :user,        'raeno'
set :password,    'j74HVK5w'

set :deploy_to, "/home/#{user}/public_html/megabookstore"

#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


namespace :deploy do
   desc 'cause Passenger to initiate restart'
   task :restart do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end

  desc 'reload the database with seed data'
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end


after "deploy:update_code", :bundle_install
after "deploy", "rvm:trust_rvmrc"

desc 'install necessary prerequisites'
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
