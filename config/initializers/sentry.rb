# Will use SENTRY_DSN environment variable if set
Sentry.init do |config|
  config.enabled_environments = %w[production]
end
