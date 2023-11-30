# frozen_string_literal: true

module PasswordFieldsHelper
  def password_toggle_field(form, method, options = {})
    options[:wrapper_data] = { controller: 'toggle-password', 'toggle-hidden': true }

    options[:data] ||= {}
    options[:data].update(target: 'toggle-password.unhide')
    options[:wrapper_classes] = 'with-trailing-icon'

    form.password_field(method, options) do
      hide_icon_tag + show_icon_tag
    end
  end

  def hide_icon_tag
    tag.i(class: :icon, data: {
            feather: 'eye-off',
            action: 'click->toggle-password#password',
            target: 'toggle-password.hide'
          })
  end

  def show_icon_tag
    tag.i(class: :icon, style: 'display: none;', data: {
            feather: 'eye',
            action: 'click->toggle-password#password',
            target: 'toggle-password.show'
          })
  end
end
