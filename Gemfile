# frozen_string_literal: true

source "https://rubygems.org"

gem "awesome_print"
gem "dotenv"
gem "dry-inflector"
gem "phlex", github: "iachettifederico/phlex", branch: "extract-to-module"
gem "puma"
gem "rackup"
gem "roda"
gem "tilt"
gem "zeitwerk"

group :development do
  gem "guard-livereload", require: false
  gem "rake"
  gem "rerun"
  gem "rubocop"
  gem "rubocop-rake"
end

group :test do
  gem "rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end
