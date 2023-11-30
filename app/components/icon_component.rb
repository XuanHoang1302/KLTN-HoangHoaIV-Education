# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  def initialize(name:, bold: false, tag: false, help: false, classes: '')
    @name = name.to_s.dasherize

    @classes = ['icon']
    @classes << 'icon--bold' if bold
    @classes << 'icon--help' if help
    @classes << 'icon--tag' if tag
    @classes += classes.split if classes

    super
  end

  def render?
    @name.present?
  end
end
