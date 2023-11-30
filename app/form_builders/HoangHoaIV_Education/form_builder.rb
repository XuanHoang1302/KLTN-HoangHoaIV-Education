# frozen_string_literal: true

module HoangHoaIVEducation
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ApplicationHelper

    delegate :concat, :content_tag, :tag, to: :@template

    def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
      additional_classes = options.delete(:wrapper_classes).to_s.split
      icon = options.delete(:icon) || :check
      icon_filename = "#{icon}.svg"

      field_wrapper(method, additional_classes: additional_classes) do
        label(method, class: 'checkbox') do |builder|
          output = tag.div(class: 'checkbox__input') do
            concat super(method, options, checked_value, unchecked_value)
            concat tag.span(class: 'checkbox__sub') { svg(icon_filename) }
          end

          label = tag.span(**options.merge(class: 'checkbox__label')) do
            block_given? ? yield : builder.translation
          end

          label += IconComponent.new(name: 'info', help: true).render_in(view_context) if options.key?(:help)

          output.concat(label).concat(error_wrapper(method))
        end
      end
    end

    def radio_button(method, tag_value, options = {})
      additional_classes = options.delete(:wrapper_classes).to_s.split

      field_wrapper(method, additional_classes: additional_classes) do
        label(method, class: 'radio', value: tag_value) do |builder|
          output = tag.div(class: 'radio__input') do
            concat super(method, tag_value, options)
            concat tag.span(class: 'radio__sub')
          end

          label = tag.span(class: 'radio__label') do
            block_given? ? yield : builder.translation
          end

          output.concat label
        end
      end
    end

    def date_field(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def email_field(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def label(method, text = nil, options = {}, &block)
      help_node = ''
      if help_text = options.delete(:help)
        help_node = tag.span class: 'has-help--long has-help--absolute', help: help_text do
          IconComponent.new(name: 'info', help: true).render_in(view_context)
        end
      end

      label_tag = method(:label).super_method.call(method, text, options, &block)
      node = Nokogiri::HTML::DocumentFragment.parse(label_tag)
      node.at_css('label') << help_node
      node.to_html.html_safe
    end

    def number_field(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def phone_field(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def text_field(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def password_field(method, options = {})
      options[:wrapper_classes] ||= ''
      options[:wrapper_classes] = (options[:wrapper_classes].to_s.split + ['field--password']).flatten.join(' ')

      text_field_layout(method, options) do
        [
          (yield if block_given?),
          super(method, options)
        ].compact.join.html_safe
      end
    end

    def text_area(method, options = {})
      text_field_layout(method, options) do
        super(method, options)
      end
    end

    def rich_text_area(method, options = {})
      text_field_layout(method, options) do
        super(method, options.merge(data: { controller: 'trix', action: 'trix-file-accept->trix#fileInserted' }))
      end
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      css_classes = %w[select]
      css_classes.push('multiple') if html_options.key?(:multiple)

      text_field_layout(method, { **options, **html_options }) do
        tag.div(class: css_classes.join(' ')) do
          super(method, choices, options, html_options, &block)
        end
      end
    end

    def file_field(method, options = {})
      options[:data] ||= {}
      options[:data].merge!({
                              file_drop_target: 'input',
                              file_input_target: 'input',
                              action: 'change->file-input#displaySelectedFiles'
                            })
      options.merge!({ direct_upload: direct_upload_enabled? })
      field_wrapper(method, additional_classes: ['with-file-input']) do
        output = @template.render(FileUploadComponent.new(self, method, options))
        output.concat error_wrapper(method)
      end
    end

    def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
      css_classes = %w[select]
      css_classes.push('multiple') if html_options.key?(:multiple)

      text_field_layout(method, html_options) do
        tag.div(class: css_classes.join(' ')) do
          super(method, collection, value_method, text_method, options, html_options)
        end
      end
    end

    def grouped_collection_select(method, collection, group_method, group_label_method, option_key_method,
                                  option_value_method, options = {}, html_options = {})
      css_classes = %w[select]
      css_classes.push('multiple') if html_options.key?(:multiple)

      text_field_layout(method, html_options) do
        tag.div(class: css_classes.join(' ')) do
          super(method, collection, group_method, group_label_method, option_key_method, option_value_method, options, html_options)
        end
      end
    end

    def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {})
      additional_classes = html_options.delete(:wrapper_classes).to_s.split

      super(method, collection, value_method, text_method, options, html_options) do |b|
        icon = options.delete(:icon) || :check
        icon_filename = "#{icon}.svg"

        field_wrapper(method, additional_classes: additional_classes) do
          b.label(class: 'checkbox') do |_builder|
            output = tag.div(class: 'checkbox__input') do
              concat b.check_box
              concat tag.span(class: 'checkbox__sub') { svg(icon_filename) }
            end

            label = tag.span(class: 'checkbox__label') do
              block_given? ? yield : b.value
            end

            output.concat label
          end
        end
      end
    end

    def errors(method, options = {})
      tag.div(class: "error #{options[:class]}", data: options[:data]) do
        error_wrapper(method)
      end
    end

    private

    def view_context
      ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    end

    def svg_path(svg_name)
      Rails.root.join('app', 'assets', 'images', svg_name)
    end

    def svg(svg_name)
      path = svg_path(svg_name)

      Rails.cache.fetch(path) do
        (File.exist?(path) ? File.binread(path) : 'not found').html_safe
      end
    end

    def text_field_layout(method, options = {})
      additional_classes = options.delete(:wrapper_classes).to_s.split
      label_text = options.delete(:label)

      if options.key?(:required)
        additional_classes << 'with-required-marker'
        required = tag.span('•')
      end

      if options.key?(:leading_icon)
        additional_classes << 'with-leading-icon'
        icon = IconComponent.new(name: options.delete(:leading_icon)).render_in(view_context)
      end

      if options.key?(:trailing_icon)
        additional_classes << 'with-trailing-icon'
        icon = IconComponent.new(name: options.delete(:trailing_icon)).render_in(view_context)
      end

      if options.key?(:icon)
        additional_classes << 'with-trailing-icon'
        icon = tag.span(class: 'icon') { options.delete(:icon) }
      end

      if label_text == false
        yield(method, options) +
          error_wrapper(method)
      else
        field_wrapper(method, additional_classes: additional_classes, data: options.delete(:wrapper_data)) do
          label(method, label_text, options.extract!(:help)) +
            required +
            icon +
            yield(method, options) +
            error_wrapper(method)
        end
      end
    end

    def field_wrapper(method, additional_classes: [], data: {}, &block)
      field_classes = %w[field] + additional_classes
      field_classes.push 'error' if error_message(method).present?
      field_classes_joined = field_classes.join(' ')

      tag.div(class: field_classes_joined, data: data, &block)
    end

    def error_wrapper(method)
      message = error_message(method)
      return if message.blank?

      tag.p(class: 'error__message') do
        concat tag.span(I18n.t('form.errors.format', message: message))
      end
    end

    def error_message(method)
      @object && @object.errors[method].to_sentence
    end

    def file_limits_message(attribute)
      return nil unless @object.respond_to?(:_validators)

      validators = @object.send(:_validators)[attribute]
      return nil unless validators.present?

      instruction = I18n.t('form.file_field.upload_instruction')
      limits = validators.join('; ')
      "#{instruction} (#{limits})"
    end
  end
end
