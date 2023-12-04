# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def app_version
    Rails.application.version
  end
end
