# frozen_string_literal: true

class Breadcrumbs::Crumb
  attr_reader :label, :path

  def initialize(label, path)
    @label = label
    @path = path
  end
end
