# frozen_string_literal: true

class CalibrationDeviceTableComponent < ViewComponent::Base
  def initialize(calibrations)
    @calibrations = calibrations
  end
end
