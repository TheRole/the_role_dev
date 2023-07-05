class Role < ApplicationRecord
  include TheRole::Api::Role

  # PostgresSQL: :json column patch
  # MIGRATION file: | t.column :the_role, :json, null: false |
  #
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #
  # def _jsonable val
  #   val.is_a?(Hash) ? val : JSON.load(val)
  # end

  # def to_hash
  #   begin the_role rescue {} end
  # end

  # def to_json
  #   the_role.is_a?(Hash) ? the_role.to_json : the_role
  # end
  #
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
end
