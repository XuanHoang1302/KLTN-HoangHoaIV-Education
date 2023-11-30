# frozen_string_literal: true

class DynamicFormComponent < ViewComponent::Base
  def initialize(dynamic_form, html_form:, data: nil, readonly: false)
    @dynamic_form = dynamic_form
    @html_form = html_form
    @data = data
    @version = @dynamic_form.version
    @readonly = readonly
  end

  def call
    version_field = @html_form.hidden_field :version, value: @version
    responses_fields = @html_form.fields_for :responses do |fields|
      render DynamicForms::SectionComponent.with_collection(
        @dynamic_form.schema.sections,
        html_form: fields,
        data: @data,
        readonly: @readonly
      )
    end

    version_field + responses_fields
  end
end
