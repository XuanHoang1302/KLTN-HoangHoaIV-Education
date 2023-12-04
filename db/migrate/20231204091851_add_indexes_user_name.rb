# frozen_string_literal: true

class AddIndexesUserName < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :users,
              :given_name,
              opclass: :gin_trgm_ops,
              using: :gin,
              algorithm: :concurrently,
              name: 'index_users_on_given_name_trgm'

    add_index :users,
              :surname,
              opclass: :gin_trgm_ops,
              using: :gin,
              algorithm: :concurrently,
              name: 'index_users_on_surname_trgm'
  end
end
