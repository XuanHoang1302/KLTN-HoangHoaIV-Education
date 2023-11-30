# frozen_string_literal: true

class AccordionComponent < ViewComponent::Base
  renders_one :price_tag
  renders_one :title
  renders_one :custom_toggle
  renders_one :details

  def initialize(closed: false, data_controller: '')
    @closed = closed
    @data_controller = data_controller
  end
end
