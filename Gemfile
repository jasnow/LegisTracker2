source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
#gem 'pg'
gem 'taps'

gem 'devise'
gem 'acts-as-taggable-on'
gem 'meta_search'
gem 'heroku'

gem 'jquery-rails'

#TODO: gem 'mysql2'
#TODO: gem 'feedzirra'
#TODO: gem 'govkit', :path => "#{File.expand_path(__FILE__)}/../vendor/gems"
#TODO: gem 'googlecharts'
#TODO: gem 'nokogiri'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda'
  gem 'factory_girl_rails'
  #gem 'factory_girl_rails' , :git => "http://github.com/CodeMonkeySteve/factory_girl_rails.git"
  gem 'faker'
  gem 'webrat'

  # Analysis Gems
  gem 'brakeman'
  gem 'cane'
end

group :test do
  gem 'cucumber-rails', :require => false

  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem "email_spec"

  # Analysis Gems
  gem 'simplecov', :require => false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
#
# To use Jbuilder templates for JSON
# gem 'jbuilder'
#
# Use unicorn as the app server
# gem 'unicorn'
#
# Deploy with Capistrano
# gem 'capistrano'
#
# To use debugger
# gem 'debugger'


