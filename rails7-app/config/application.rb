require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails7App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.paths["app/views"] << Rails.root.join("../the_role_specs/_TEST_APP_/views")
    config.paths["app/models"] << Rails.root.join("../the_role_specs/_TEST_APP_/models")
    config.paths["app/controllers"] << Rails.root.join("../the_role_specs/_TEST_APP_/controllers")

    config.paths["db/migrate"] << Rails.root.join("../the_role_specs/_TEST_APP_/db/migrate")
    config.paths["config/locales"] << Rails.root.join("../the_role_specs/_TEST_APP_/locales")
    config.paths["config/routes.rb"] << Rails.root.join("../the_role_specs/_TEST_APP_/routes.rb")
    config.paths["config/initializers"] << Rails.root.join("../the_role_specs/_TEST_APP_/initializers")

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
