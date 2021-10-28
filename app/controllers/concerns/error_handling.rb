module ErrorHandling
  extend ActiveSupport::Concern

  included do
    # :nocov:
    rescue_from Exception do |exception|
      raise if Rails.application.config.consider_all_requests_local

      Sentry.capture_exception(exception)

      redirect_to unhandled_errors_path
    end
    # :nocov:
  end
end
