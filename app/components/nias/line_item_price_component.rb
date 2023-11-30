# frozen_string_literal: true

class Nias::LineItemPriceComponent < ViewComponent::Base
  def initialize(request:, customer_item:)
    @request = request
    @price = customer_item.price
    @line_item = customer_item.item
  end

  def results_status
    return :na unless @line_item.expected_results.present?
    return :missing unless @line_item.results.present?
    return :pending if @line_item.results.any?(&:pending?)
    return :accepted if @line_item.expected_results.all? { |result_type| accepted_result?(@line_item.results, result_type) }

    :missing
  end

  private

  def accepted_result?(result_list, result_type)
    result_list.select { |result| result.result_type == result_type }
               .select(&:accepted?)
               .present?
  end
end
