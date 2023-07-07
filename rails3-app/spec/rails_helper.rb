# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('../', 'the_role_specs', 'specs', 'factories', '**', '*.rb')].sort.each { |f| require f }

# Return default text on "Access Denied" page
def access_denied_match
  "redirected"
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
