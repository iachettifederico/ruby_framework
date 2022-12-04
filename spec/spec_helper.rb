ENV['ENVIRONMENT_NAME'] = "test"

if ENV["COVERAGE"] == "true"
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
    add_filter "/config/"
    add_filter "/framework/"
  end

  require "./boot"
  APPLICATION_LOADER.eager_load
  puts "Running specs with coverage".yellow
else
  require "./boot"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random
end

require "rake"

FileList["./spec/support/**/*.rb"].each do |file|
  require file
end
