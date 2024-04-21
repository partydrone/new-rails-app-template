require "simplecov"
require "simplecov-lcov"
require "simplecov-tailwindcss"

SimpleCov.start "rails" do
  enable_coverage :branch

  add_filter "app/assets"
  add_filter "app/channels"
  add_filter "app/javascript"
  add_filter "config"
  add_filter "db"
  add_filter "test"

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Helpers", "app/helpers"
  add_group "Jobs", "app/jobs"
  add_group "Mailers", "app/mailers"
  add_group "Libraries", "lib"

  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end

  coverage_dir "tmp/coverage"
end

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::TailwindFormatter
])

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
