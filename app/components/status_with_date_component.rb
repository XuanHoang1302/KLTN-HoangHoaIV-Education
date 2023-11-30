# frozen_string_literal: true

class StatusWithDateComponent < ViewComponent::Base
  def initialize(model, expiration_date, enum: :status, status: nil)
    @model = model
    @expiration_date = expiration_date
    @enum = enum
    @status = status || model.send(enum) || model.current_status
  end

  def expired_message
    @expiration_date.to_s
  end

  private

  def status_color
    return 'expired' if Time.zone.parse(@expiration_date.to_s).past?
    return 'near' if Time.zone.parse(@model.notification_before_expiration_date.to_s).past?

    'in-time'
  end
end
