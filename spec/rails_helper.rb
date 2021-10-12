ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec::Expectations.configuration.on_potential_false_positives = :nothing

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include(ActiveSupport::Testing::TimeHelpers)

  config.before(:each, js: true) do
    page.driver.browser.url_whitelist = %w(127.0.0.1 localhost)
  end

  config.use_transactional_fixtures = true
end

RSpec::Matchers.define_negated_matcher :not_change, :change
