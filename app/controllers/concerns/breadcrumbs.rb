# frozen_string_literal: true

# Add breadcrumbs to a controller
#   * The first crumb will always be the dashboard ("/dashboard")
#   * Additional crumbs will be added on top of the dashboard
#   * The last crumb will be the "active" crumb and won't be rendered as a link
#
#   Example usage:
#
#     class MyController < ApplicationController
#       drop_breadcrumb I18n.t(".admin"), :admin_dashboard_path
#       drop_breadcrumb I18n.t(".settings"), :settings_path, only: :show
#
#       def index
#         drop_breadcrumb t(".terms"), terms_path
#         drop_breadcrumb t(".edit_terms")
#       end
#     end

module Breadcrumbs
  extend ActiveSupport::Concern
  included do
    helper_method :breadcrumbs
  end

  class_methods do
    def drop_breadcrumb(*args, **options)
      label, path = args

      before_action(options) do |controller|
        controller.send(:drop_breadcrumb, label, path)
      end
    end
  end

  private

  def drop_breadcrumb(label, path = nil)
    path = send(path) if path.is_a? Symbol

    label = instance_exec(&label) if label.is_a? Proc
    path = instance_exec(&path) if path.is_a? Proc

    breadcrumbs << Crumb.new(label, path)
  end

  def breadcrumbs
    @breadcrumbs ||= Trail.new(Crumb.new(I18n.t('layouts.application.virtual_lab'), dashboard_path))
  end
end
