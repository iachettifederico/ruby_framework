require "zeitwerk"

APPLICATION_LOADER = Zeitwerk::Loader.new

settings = Settings.new

settings.load_dirs.each do |directory_to_load|
  APPLICATION_LOADER.push_dir(directory_to_load)
end

APPLICATION_LOADER.setup
