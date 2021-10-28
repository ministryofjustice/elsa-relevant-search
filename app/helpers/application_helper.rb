module ApplicationHelper
  def service_name
    t('service.name')
  end

  def title(page_title)
    content_for :page_title, [page_title.presence, service_name, 'GOV.UK'].compact.join(' - ')
  end

  def fallback_title
    exception = StandardError.new("page title missing: #{controller_name}##{action_name}")
    raise exception if Rails.application.config.consider_all_requests_local

    Sentry.capture_exception(exception)

    title ''
  end

  def link_button(text, href, attributes = {})
    link_to t("helpers.buttons.#{text}"), href, {
      class: 'govuk-button',
      data: { module: 'govuk-button' },
    }.merge(attributes)
  end

  def analytics_tracking_id
    ENV['GA_TRACKING_ID']
  end

  # Use this to feature-flag code that should only run/show on test environments
  def dev_tools_enabled?
    Rails.env.development? || ENV.key?('DEV_TOOLS_ENABLED')
  end
end
