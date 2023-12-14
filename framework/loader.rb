# frozen_string_literal: true

require "zeitwerk"

APPLICATION_LOADER = Zeitwerk::Loader.new

settings = Settings.new

settings.load_dirs.each do |directory_to_load|
  APPLICATION_LOADER.push_dir(directory_to_load)
end

settings.ignore_dirs.each do |directory_to_ignore|
  APPLICATION_LOADER.ignore(directory_to_ignore)
end

APPLICATION_LOADER.setup

APPLICATION_LOADER.eager_load
