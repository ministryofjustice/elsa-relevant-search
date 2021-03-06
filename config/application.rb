require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

require "active_support/core_ext/integer/time"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ElsaRelevantSearch
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Survey in the phase banner (header)
    config.x.survey_link = 'https://eu.surveymonkey.com/r/P6BKSSF'

    # Load the common search terms configuration
    config.x.common_terms = YAML.load_file(
      File.join(Rails.root, 'config', 'common_terms.yml')
    )

    # Cookies permission banner
    config.x.cookies_consent_name = 'elsa_cookies_consent'.freeze
    config.x.cookies_consent_expiration = 1.year
  end
end
