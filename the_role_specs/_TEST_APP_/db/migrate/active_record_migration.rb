def active_record_migration
  if Rails::VERSION::MAJOR >= 5
    version = "#{Rails::VERSION::MAJOR}.0".to_f
    ActiveRecord::Migration[version]
  else
    ActiveRecord::Migration
  end
end
