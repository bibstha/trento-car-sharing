require 'bundler/capistrano'
require 'rvm/capistrano'
# load 'lib/deploy/seed'

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:

set :application, "Trento Car Sharing"
set :repository,  "https://github.com/bibstha/trento-car-sharing.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :scm, "git"
set :user, "www-data"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/universiad2013.88yaks.com"
set :use_sudo, false

role :web, "88yaks.com"                          # Your HTTP server, Apache/etc
role :app, "88yaks.com"                          # This may be the same as your `Web` server
role :db,  "88yaks.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Synchronize mongo databases
set :mongodbname_prod, 'trento_car_sharing_production'
set :mongodbname_dev, 'trento_car_sharing_development'

namespace :sync do
  desc 'Synchronize local MongoDB with production.'
  task :mongodb, :roles => "#{:db}" do
    run "cd"
    run "mongodump --host localhost -d #{mongodbname_prod}"
    current_host = capture("echo $CAPISTRANO:HOST$").strip
    system "scp -Cr #{user}@#{current_host}:~/dump/#{mongodbname_prod}/ db/dumps/"
    system "mongorestore -h localhost --drop -d #{mongodbname_dev} db/dumps/#{mongodbname_prod}"
  end
end