# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  default_form_builder HoangHoaIVEducation::FormBuilder
  append_view_path "#{Rails.root}/app/components"
  helper_method :turbo_frame_request?

  include Authentication
  include SetCurrentRequestDetails
  include AutocompleteFields
  include Breadcrumbs
end
