# frozen_string_literal: true

class StepperComponent < ViewComponent::Base
  include SvgHelper

  def initialize(stepper, link_steps: true, show_subheaders: true, additional_classes: nil)
    @stepper = stepper
    @link_steps = link_steps
    @show_subheaders = show_subheaders
    @additional_classes = additional_classes
  end

  def linkable?(step_name)
    return false unless step_path(step_name)

    @stepper.step_complete?(step_name) || @stepper.next_available_step?(step_name)
  end

  def step_path(step_name)
    return nil unless @link_steps && @stepper.step(step_name).path.present?

    @stepper.step(step_name).path ||
      "#{@step_path}&step=#{@stepper.step_number(for_step: step_name)}"
  end

  def classes
    [
      'stepper',
      @additional_classes
    ].compact.join(' ')
  end
end
