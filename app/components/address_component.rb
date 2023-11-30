# frozen_string_literal: true

class AddressComponent < ViewComponent::Base
  def initialize(address:, name: nil)
    @address = address
    @name = name
  end
end
