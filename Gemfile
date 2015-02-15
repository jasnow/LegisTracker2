source 'https://rubygems.org'

gem 'rails', '3.2.21'

gem 'devise'
gem 'acts-as-taggable-on'
gem 'meta_search'

gem 'blueprint-rails'

# (now use heroku toolbelt) gem 'heroku'

gem 'feedjira'

gem 'googlecharts'

gem 'govkit', :path => "#{File.expand_path(__FILE__)}/../vendor/gems"

gem 'nokogiri'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'thin'

group :development do
  gem 'dawnscanner', :require => false
end

group :development, :test do
  # DATABASE-RELATED
  gem 'sqlite3'
  gem 'mysql2'

  gem 'yaml_db'
  #gem 'pg'
  gem 'taps'

  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'webrat'
  gem "capybara"
  gem 'test-unit'

  #10/25/2012: Checked/Appears to not be used in production.
  gem 'capybara-screenshot'

  gem 'rails-footnotes'

  gem 'better_errors'
  gem 'binding_of_caller'

  # Analysis Gems
  gem 'brakeman'
  gem 'cane'
  gem 'holepicker'
end

group :test do
  gem 'cucumber', '2.0.0.rc.4'
  gem 'cucumber-rails', :require => false

  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
#, '1.0.1'
  gem "email_spec"

  gem "autotest-rails"
  gem "autotest-fsevent"
  gem "autotest-growl"
  gem "launchy"

  # Analysis Gems
  gem 'simplecov', :require => false
end

group :production, :staging do
  gem "pg"
end
