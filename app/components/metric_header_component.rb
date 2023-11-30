# frozen_string_literal: true

class MetricHeaderComponent < ViewComponent::Base
  def initialize(metrics:, search_id:)
    @metrics = metrics
    @search_id = search_id
  end
end
