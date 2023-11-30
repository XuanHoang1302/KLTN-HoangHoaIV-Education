# frozen_string_literal: true

class MetricComponent < ViewComponent::Base
  def initialize(metrics:, search_id:)
    @metrics = metrics
    @search_id = search_id
  end
end
