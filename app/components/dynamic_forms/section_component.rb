# frozen_string_literal: true

module DynamicForms
  class SectionComponent < ViewComponent::Base
    with_collection_parameter :section

    def initialize(section:, html_form:, data:, readonly:)
      @section = section
      @data = data&.fetch(@section.key, nil)

      @html_form = html_form
      @readonly = readonly
    end
  end
end
