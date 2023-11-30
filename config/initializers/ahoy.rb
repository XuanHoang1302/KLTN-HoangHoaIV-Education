# frozen_string_literal: true

class Ahoy::Store < Ahoy::DatabaseStore
  def authenticate(data)
    # Disables automatic linking of visits and users
  end
end

Ahoy.api = true # Enable JS tracking
Ahoy.mask_ips = true # Mask IP address for GDPR compliance
Ahoy.cookies = false # Disable cookies for GDPR compliance

# Disable tracking for environments other than production
# By default, the tracking is disabled.
Ahoy.exclude_method = lambda do |_controller, _request|
  ActiveModel::Type::Boolean.new.cast(
    ENV.fetch('AHOY_DISABLED', true)
  )
end
