ENV['ENVIRONMENT_NAME'] = "test"

require "./boot"

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
