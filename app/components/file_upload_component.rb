# frozen_string_literal: true

class FileUploadComponent < ViewComponent::Base
  def initialize(form, method, options)
    @form = form
    @method = method
    @options = options
  end

  def limits_message
    instruction = @options.fetch(:label, I18n.t('form.file_field.upload_instruction'))
    limits = I18n.t('form.file_field.upload_limit', size_limit: @options[:excel_only] ? '10MB' : '100MB')
    type_accept = @options[:accept_short_keyword] || @options[:accept]
    limits = "#{type_accept}; #{limits}" if @options[:accept].present? || @options[:accept_short_keyword].present?

    # limits_message_from_validator || "#{instruction} (#{limits})"
    "#{instruction} (#{limits})"
  end

  private

  def limits_message_from_validator
    return nil unless @form.object.respond_to?(:_validators)

    validators = @form.object.send(:_validators)[@method]
    return nil unless validators.present?

    instruction = I18n.t('form.file_field.upload_instruction')
    limits = validators.join('; ')
    "#{instruction} (#{limits})"
  end
end
