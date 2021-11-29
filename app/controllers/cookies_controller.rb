class CookiesController < ApplicationController
  CONSENT_ALLOWED_VALUES = %w[accept reject].freeze

  def show; end

  def update
    cookies[cookie_name] = {
      expires: expiration,
      value: accept_or_reject
    }

    redirect_back fallback_location: root_path, flash: { cookies_consent_updated: accept_or_reject }
  end

  private

  # We filter the param to ensure it is either `accept` or `reject`, and if
  # it is none of those values, we default to `reject` as a precaution.
  def accept_or_reject
    (CONSENT_ALLOWED_VALUES & Array(params.require(:cookies))).first || 'reject'
  end

  def cookie_name
    Rails.configuration.x.cookies_consent_name
  end

  def expiration
    Rails.configuration.x.cookies_consent_expiration
  end
end
