# frozen_string_literal: true

class FilterComponent < ViewComponent::Base
  # Type can be `:sort` or `:filter`. See `Sortable` and `Filterable`
  def initialize(column, type: :filter, options: nil, url: nil, url_date: nil, addition_style: nil)
    model_name, attribute_name = column.split('.')
    @url = url
    @url_date = url_date
    @model = model_name.constantize
    @type = type
    @attribute = attribute_name.to_sym
    @options = options
    @addition_style = addition_style
  end

  def translation_for(option)
    if @type == :sort
      t("table_sort_options.#{option}")
    elsif @model.respond_to?(:human_enum_name)
      fallback = @model.human_enum_name(@attribute, option)
      t("#{@model.model_name.i18n_key}.filter_options.#{@attribute}.#{option}", default: fallback)
    else
      option.titleize
    end
  end

  def classes_for(option)
    class_names({ 'selected' => option_selected?(option) })
  end

  def link_for(option)
    query_parameters = request.query_parameters.dup.with_indifferent_access
    query_parameters.merge!(params_for(option)) do |_key, a, b|
      if a.is_a?(Hash)
        # If the param is a hash, merge with the option params. Exclude the param if it's the selected option
        # (the value of the param is nil, returned by the option_selected) and return the merged hash
        a.merge(b) { |_child_key, _child_a, child_b| child_b.nil? ? nil : child_b }.compact
      else
        # Exclude this param if the option is not selected
        option_selected?(option) ? nil : b
      end
    end.compact!

    "#{request.path}?#{query_parameters.to_query}"
  end

  def option_selected?(option)
    if @type == :sort
      request.query_parameters["#{@type}_by".to_sym] == "#{@model}.#{@attribute}.#{option}"
    elsif @type == :filter && request.query_parameters["#{@type}_by".to_sym].present?
      request.query_parameters["#{@type}_by".to_sym]["#{@model}.#{@attribute}"] == option
    end
  end

  private

  # format of the params in the query string:
  # sort_by: sort_by=Model.attribute.option
  # filter_by: filter_by%5BModel.attribute%5D=option # [ and ] are url encoded as per the standard
  def params_for(option)
    options = if @type == :sort
                { sort_by: option_selected?(option) ? nil : "#{@model}.#{@attribute}.#{option}" }
              else
                { filter_by: {
                  "#{@model}.#{@attribute}" => option_selected?(option) ? nil : option
                } }
              end
    options.merge!('page' => 1) if @type == :filter

    options
  end
end
