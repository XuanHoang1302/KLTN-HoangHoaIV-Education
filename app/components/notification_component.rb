# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  renders_one :message
  renders_one :details

  def initialize(type:, id:, auto_scroll: false)
    @type = type
    @id = id
    @auto_scroll = auto_scroll
  end

  def style
    case @type
    when 'info', 'notice'
      ''
    when 'error', 'alert'
      ' notification--error'
    when 'success'
      ' notification--success'
    when 'coming-soon'
      ' notification--coming-soon'
    end
  end

  def icon
    case @type
    when 'info', 'notice'
      'info'
    when 'error', 'alert'
      'alert-circle'
    when 'success'
      'check-circle'
    when 'coming-soon'
      'package'
    end
  end
end
