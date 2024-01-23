# frozen_string_literal: true

require "dotenv"
Dotenv.load(
  ".env.#{ENV.fetch('ENVIRONMENT_NAME')}.local",
  ".env.#{ENV.fetch('ENVIRONMENT_NAME')}",
  ".env",
)

require_relative "framework/paths"
require_relative "config/settings"
require_relative "framework/initializers"
require_relative "framework/loader"
