# frozen_string_literal: true

class StatusWithTagComponent < ViewComponent::Base
  def initialize(model, enum: :status, status: nil)
    @model = model
    @enum = enum
    @status = status || model.send(enum) || model.current_status
  end

  def humanized_status
    @model.send(:human_enum_name, @enum, @status)
  end

  def tag_classes
    "tag__indicator #{status_tag_color}"
  end

  private

  def status_tag_color
    @model.send("#{@enum}_colors").fetch(@status, 'bg--light-grey')
  end
end
