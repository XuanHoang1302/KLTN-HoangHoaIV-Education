# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show], except: [:mark_all_read]

  def index
    @notifications = Current.user.notifications.unread.newest_first
  end

  def show
    @notification.mark_as_read!
    redirect_to @notification.to_notification.path
  end

  def mark_all_read
    Notification.transaction do
      Current.user.notifications.unread.update_all(read_at: Time.current)
    end
    redirect_back fallback_location: root_path
  end

  private

  def set_notification
    @notification = Current.user.notifications.find(params[:id])
  end
end
