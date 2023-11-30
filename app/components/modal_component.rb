# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  def initialize(id:, title: nil, icon: '', show_actions: true, show_close: true, classes: nil, form_id: nil,
                 data_options: {})
    @id = id
    @title = title
    @icon = icon

    @classes = classes
    @show_actions = show_actions
    @show_close = show_close
    @form_id = form_id
    @data = data_options[:data]
    @title_data = data_options[:title_data]
    @cancel_data = data_options[:cancel_data]
    @confirm_data = data_options[:confirm_data]
  end

  def cancel_data
    return { 'micromodal-close': '' } unless @cancel_data.present?

    @cancel_data
  end
end
