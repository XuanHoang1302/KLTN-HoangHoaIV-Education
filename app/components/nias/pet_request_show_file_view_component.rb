# frozen_string_literal: true

class Nias::PetRequestShowFileViewComponent < ViewComponent::Base
  include ResultsHelper

  def initialize(request:, line_item:)
    @request = request
    @line_item = line_item
    @results = @line_item.results.to_a.sort_by(&:created_at).reverse.group_by(&:result_type)
  end
end
