# frozen_string_literal: true

module Nias
  class PetRequestShowElementAnalysisComponent < ViewComponent::Base
    def initialize(request:, analysis:)
      @request = request
      @analysis = analysis
      @analysis_item = @analysis.is_a?(Nias::CompositionAnalysis) ? @analysis : @analysis.item
      @composition_analysis_attributes = %i[analysis_type notes]
    end
  end
end
