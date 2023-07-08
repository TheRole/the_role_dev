# /home/the_role_dev/rails6-app# bundle exec rspec ../the_role_specs/specs/models/hash_spec.rb
require 'rails_helper'
require "rspec/rails/version"

describe "Testing Environment" do
  context "Information" do
    it "is what we have" do
      puts ">" * 70
      puts "RUBY_VERSION = #{RUBY_VERSION}"
      puts "RAILS VERSION = #{Rails.version}"
      puts "RSPEC VERSION = #{RSpec::Rails::Version::STRING}"
      puts ">" * 70
    end
  end
end
