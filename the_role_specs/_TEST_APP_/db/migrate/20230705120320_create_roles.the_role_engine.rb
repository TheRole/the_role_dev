# This migration comes from the_role_engine (originally 20111025025129)

# rails g the_role install
# rake the_role_engine:install:migrations
# rake db:migrate
# rake db:the_role:admin
class CreateRoles < ActiveRecord::Migration[5.2]
  def self.up
    create_table :roles do |t|
      t.string :name,        null: false
      t.string :title,       null: false
      t.text   :description, null: false
      t.text   :the_role,    null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
