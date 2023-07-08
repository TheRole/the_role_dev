require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails4App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.paths["app/views"] << Rails.root.join("../the_role_specs/_TEST_APP_/views")
    config.paths["app/models"] << Rails.root.join("../the_role_specs/_TEST_APP_/models")
    config.paths["app/controllers"] << Rails.root.join("../the_role_specs/_TEST_APP_/controllers")

    config.paths["db/migrate"] << Rails.root.join("../the_role_specs/_TEST_APP_/db/migrate")
    config.paths["config/locales"] << Rails.root.join("../the_role_specs/_TEST_APP_/locales")

    config.paths['config/routes.rb'] << Rails.root.join("../the_role_specs/_TEST_APP_/routes.rb")
    config.paths["config/initializers"] << Rails.root.join("../the_role_specs/_TEST_APP_/initializers")

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
