# frozen_string_literal: true

class OtherAddressComponent < ViewComponent::Base
  def initialize(address:, name: nil)
    @address = address
    @name = name
  end
end
