module AnalyticsHelper
  def analytics_tracking_id
    ENV['GA_TRACKING_ID']
  end

  def analytics_consent_cookie
    cookies[Rails.configuration.x.cookies_policy_name]
  end

  def analytics_allowed?
    analytics_tracking_id.present? && analytics_consent_cookie.eql?('accept')
  end
end
