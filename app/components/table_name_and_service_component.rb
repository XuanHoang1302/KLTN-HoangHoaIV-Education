# frozen_string_literal: true

class TableNameAndServiceComponent < ViewComponent::Base
  def initialize(name:, type:, link:, length: nil)
    @name = name
    @type = type
    @link = link
    @length = length
    return if @length.present?

    @length = case @type
              when 'name', 'service' then 32
              when 'description' then 50
              else 24
              end
  end
end
