# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  class InvalidButtonStyle < StandardError; end

  BUTTON_STYLES = %i[primary accent secondary negative ghost].freeze

  def initialize(label:, style: 'primary', mini: false, additional_classes: nil, data: nil)
    raise InvalidButtonStyle if BUTTON_STYLES.none?(style.to_sym)

    @style = style
    @label = label
    @mini = mini
    @additional_classes = additional_classes
    @data = data
  end

  def classes
    [
      "button--#{@style}",
      @mini ? 'button--mini' : nil,
      @additional_classes
    ].compact.join(' ')
  end

  def data_attributes
    return unless @data.present?

    @data.map do |key, value|
      "data-#{key}=#{value}"
    end.join(' ')
  end
end
