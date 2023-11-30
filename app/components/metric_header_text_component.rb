# frozen_string_literal: true

class MetricHeaderTextComponent < ViewComponent::Base
  def initialize(metrics:, stat_key:, stat_value:, search_id:)
    @metrics = metrics
    @stat_key = stat_key
    @stat_value = stat_value
    @search_id = search_id
  end
end
