# frozen_string_literal: true

require "role_based_access_control"
require "simplecov"

RSpec.configure do |config|
  ENV["APP_ENV"] = "test"

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  SimpleCov.start
end
