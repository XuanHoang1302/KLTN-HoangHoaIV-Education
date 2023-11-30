# frozen_string_literal: true

module Nias
  class PetRequestShowElementMigrationComponent < ViewComponent::Base
    include LineItemHelper

    def initialize(request:, migration:)
      @request = request
      @migration = migration
      @migration_item = @migration.is_a?(Nias::OverallMigration) || @migration.is_a?(Nias::SpecificMigration) ? @migration : @migration.item
      @migration_data = @migration.is_a?(Nias::OverallMigration) || @migration.is_a?(Nias::SpecificMigration) ? @migration_item : @migration_item[:data]
    end

    def not_line_item?
      @migration_item.is_a?(Nias::SpecificMigration) || @migration_item.is_a?(Nias::OverallMigration)
    end

    def specific_migration?
      @migration.is_a?(Nias::SpecificMigration) || @migration.item.origin.is_a?(Nias::SpecificMigration)
    end
  end
end
