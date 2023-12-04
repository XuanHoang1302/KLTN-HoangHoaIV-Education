# frozen_string_literal: true

class DashboardController < ApplicationController

  drop_breadcrumb I18n.t('layouts.application.dashboard'), :dashboard_path
  def show

  end
end
