# frozen_string_literal: true

module AutocompleteFields
  extend ActiveSupport::Concern

  class_methods do
    def autocomplete(name, collection, limit: 25, field_name: nil)
      define_method :"autocomplete_#{name}" do
        field_name = name unless field_name.present?
        safe_keyword = ActiveRecord::Base.connection.quote(params[:keyword])
        results = collection

        results = if params[:keyword].present? && params[:keyword].length > 2
                    results
                      .select("#{field_name} as name", Arel.sql("similarity(#{safe_keyword}, #{field_name}) as score"))
                      .where(Arel.sql("similarity(#{safe_keyword}, #{field_name}) > 0.01"))
                      .order(score: :desc)
                  else
                    results.select("#{field_name} as name")
                  end

        results = results
                  .distinct(field_name)
        records = ActiveRecord::Base.connection.execute("#{results.to_sql} LIMIT #{limit}")

        respond_to do |format|
          format.json do
            render json: records
              .map { |e| e.fetch('name', nil) || e.fetch('?column?', nil) }
              .map { |e| { id: e, name: e } }
              .to_json
          end
        end
      end
    end
  end
end
