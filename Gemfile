source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').chomp

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'pg'
gem 'puma'

# Exceptions notifications
gem 'sentry-ruby'
gem 'sentry-rails'

# Assets management
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :production do
  gem 'lograge'
  gem 'logstash-event'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
end

group :test do
  gem 'brakeman'
  gem 'capybara', '>= 3.26'
  gem 'capybara-screenshot-diff'
  gem 'cucumber-rails', require: false
  gem 'rails-controller-testing'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'simplecov-rcov'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
