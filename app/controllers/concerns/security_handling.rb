module SecurityHandling
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :exception, prepend: true

    before_action :check_http_credentials,
                  :drop_dangerous_headers!

    after_action :set_security_headers
  end

  private

  def drop_dangerous_headers!
    request.env.except!('HTTP_X_FORWARDED_HOST') # just drop the variable
  end

  def set_security_headers
    additional_headers_for_all_requests.each do |name, value|
      response.set_header(name, value)
    end
  end

  def additional_headers_for_all_requests
    {
      'X-Frame-Options'           => 'SAMEORIGIN',
      'X-XSS-Protection'          => '1; mode=block',
      'X-Content-Type-Options'    => 'nosniff',
      'Strict-Transport-Security' => 'max-age=15768000; includeSubDomains',
    }
  end

  # :nocov:
  def authenticate_internal_user(username, password)
    username == ENV.fetch('HTTP_AUTH_USER') && password == ENV.fetch('HTTP_AUTH_PASSWORD')
  end

  def check_http_credentials
    return unless ENV.fetch('HTTP_AUTH_ENABLED', false)

    authenticate_or_request_with_http_basic(
      &method(:authenticate_internal_user)
    )
  end
  # :nocov:
end
