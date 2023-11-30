# frozen_string_literal: true

class SearchResultComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(company, search, search_result, context:, is_favorite: false, **attrs)
    @company = company
    @search = search
    @search_result = search_result
    @favorite = is_favorite
    @context = context
    @score = attrs[:score]
    @distance = attrs[:distance]&.to_i
    @delivery_time = attrs[:delivery_time]
    @position = attrs[:position]
    @selected = attrs[:selected]
  end

  def score
    @score || @search_result.match_score(@search)
  end

  def distance
    @distance || @search_result.distance_from(@search.location)
  end

  def delivery_time
    return nil unless @search_result.execution_time_minutes.present?

    @delivery_time || (@search_result.execution_time_minutes_input * @search.examination_count)
  end

  def associated_parameters
    return [] unless @search.present?
    return @associated_parameters if @associated_parameters.present?

    matched_parameters = @search_result.associated_parameters.all.map do |associated_parameter|
      [associated_parameter, search_parameter_for(associated_parameter)]
    end

    @associated_parameters = matched_parameters.concat search_only_parameters.map { |ap| [nil, ap] }

    @associated_parameters
  end

  def associated_parameter_match_glyph(service_param, search_param)
    return IconComponent.new(name: 'exclamation') if service_param.nil?

    matches = service_param.matches? search_param
    if matches.nil?
      IconComponent.new(name: 'exclamation')
    else
      glyph_for matches
    end
  end

  def characteristic_match_glyph(characteristic)
    if search_characteristic = @search&.send(characteristic)
      glyph_for search_characteristic == @search_result.send(characteristic)
    else
      '—'
    end
  end

  def cold_vendor?
    @search_result.company.cold_vendor?
  end

  def verified_vendor?
    @search_result.company.verified?
  end

  def display_for_search_parameter(service_parameter, search_parameter)
    return search_parameter.human_readable_values if search_parameter.present?

    service_parameter.important? ? t('.parameter_recommended') : nil
  end

  def vendor
    "#{t('search_result_component.vendor_name')}: #{@search_result.company.name}"
  end

  def glyph_for(boolean)
    IconComponent.new(name: !!boolean ? 'check' : 'x')
  end

  private

  def search_only_parameters
    result_parameter_ids = @search_result.associated_parameters.map(&:parameter_id)
    @search.associated_parameters.select do |ap|
      result_parameter_ids.exclude?(ap.parameter_id) && ap.parameter_id.present?
    end
  end

  def search_parameter_for(associated_parameter)
    @search.associated_parameters.find do |parameter|
      parameter.parameter_id == associated_parameter.parameter_id
    end
  end
end
