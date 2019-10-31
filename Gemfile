source 'https://rubygems.org'

gem 'rails', '3.2.22.5'

gem 'devise'
gem 'acts-as-taggable-on'
gem 'meta_search'
gem 'blueprint-rails'
gem 'feedjira'
gem 'googlecharts'
gem 'govkit', path: "#{File.expand_path(__FILE__)}/../vendor/gems"
gem 'nokogiri'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

group :development do
  gem 'dawnscanner', require: false
end

group :development, :test do
  # DATABASE-RELATED
  gem 'sqlite3', '1.3.13' # 2/7/2019: LOCKED DOWN
  gem 'mysql2'

  gem 'yaml_db'
  # gem 'pg'

  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'webrat'
  gem 'capybara'
  gem 'test-unit'

  # 10/25/2012: Checked/Appears to not be used in production.
  gem 'capybara-screenshot'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rubocop-rspec'

  # Analysis Gems
  gem 'railroader'
  gem 'cane'
  gem 'holepicker'
end

group :test do
  gem 'cucumber'
  gem 'cucumber-rails', require: false

  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'email_spec'

  gem 'launchy'

  # Analysis Gems
  gem 'simplecov', require: false
end

group :production, :staging do
  gem 'pg'
end
