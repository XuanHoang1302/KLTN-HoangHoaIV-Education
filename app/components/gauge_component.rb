# frozen_string_literal: true

class GaugeComponent < ViewComponent::Base
  def initialize(step:, steps:)
    @step = step.to_i
    @steps = steps.to_i
  end

  def percent_complete
    return 0.0 if @steps.to_f.zero?

    (@step.to_i / @steps.to_f) * 100.0
  end
end
