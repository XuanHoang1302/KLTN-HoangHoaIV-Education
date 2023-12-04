# frozen_string_literal: true

# The `Notification` record is the general-entry record for our notification
# system. This notification system is based on Noticed, a gem by @excid3.
#
# All current notification types can be found in `app/notifications`. To learn
# more about `Noticed`, see https://github.com/excid3/noticed
class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  after_create_commit do
    broadcast_prepend_later_to [recipient, :notifications], target: 'notifications',
                               partial: 'notifications/notification', locals: { notification: self }
    broadcast_replace_later_to [recipient, :unread_notifications], target: 'unread_notifications',
                               partial: 'notifications/unread_count', locals: { unread_count: recipient.notifications.unread.count }
  end
end
