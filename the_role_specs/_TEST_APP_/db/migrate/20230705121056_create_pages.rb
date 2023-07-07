require_relative './active_record_migration'

# rails g model page user_id:integer person_id:integer title:string content:text state:string
# rake db:migrate
class CreatePages < active_record_migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :person_id

      t.string :title
      t.text :content
      t.string :state, default: :draft

      t.timestamps
    end
  end
end
