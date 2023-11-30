# frozen_string_literal: true

module Nias
  class PetRequestShowElementComponent < ViewComponent::Base
    def initialize(request:, bundles:)
      @request = request
      @draft = @request.draft?
      @confirmed = @request.confirmed? || @request.processing?
      @bundles = bundles
      @sample_attributes = if Current.company.buyer?
                             %i[reference_number sampling_date report_format shape collection_system collection_country_code
                                decontamination_technology rpet_content machine_number rin_number]
                           else
                             %i[reference_number sampling_date shape]
                           end
    end
  end
end
