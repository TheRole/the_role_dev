require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails5app
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.paths["app/views"] << Rails.root.join("../the_role_specs/_TEST_APP_/views")
    config.paths["app/models"] << Rails.root.join("../the_role_specs/_TEST_APP_/models")
    config.paths["app/controllers"] << Rails.root.join("../the_role_specs/_TEST_APP_/controllers")

    config.paths["db/migrate"] << Rails.root.join("../the_role_specs/_TEST_APP_/db/migrate")
    config.paths["config/locales"] << Rails.root.join("../the_role_specs/_TEST_APP_/locales")
    config.paths["config/routes.rb"] << Rails.root.join("../the_role_specs/_TEST_APP_/routes.rb")
    config.paths["config/initializers"] << Rails.root.join("../the_role_specs/_TEST_APP_/initializers")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
