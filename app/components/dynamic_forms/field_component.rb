# frozen_string_literal: true

module DynamicForms
  class FieldComponent < ViewComponent::Base
    with_collection_parameter :field

    def initialize(field:, html_form:, data:, readonly:)
      @field = field
      @value = data&.fetch(@field.name, nil)

      @html_form = html_form
      @data = data
      @readonly = readonly

      @type = @field.type.chomp('_field')
    end

    def call
      if @type == 'file'
        files = @value&.fetch('signed_ids', nil)&.reject(&:blank?)&.map { |id| find_blob(id) }

        locals = { form: @html_form, label: @field.label, name: @field.name, files: files, readonly: @readonly }
        render '/dynamic_forms/file_field', locals
      else
        @html_form.send(@field.type, @field.name, label: @field.label, value: @value, readonly: @readonly,
                                                  required: true)
      end
    end

    private

    def find_blob(signed_id)
      ActiveStorage::Blob.find_signed signed_id
    end
  end
end
