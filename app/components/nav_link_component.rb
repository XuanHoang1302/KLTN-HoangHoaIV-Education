# frozen_string_literal: true

class NavLinkComponent < ViewComponent::Base
  def initialize(title:, href:, icon: '', active_strategy: :exclusive)
    @title = title
    @href = href
    @icon = icon
    @active_strategy = active_strategy
  end
end
