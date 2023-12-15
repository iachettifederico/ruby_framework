# frozen_string_literal: true

module Views
  class ApplicationView < Layouts::ApplicationLayout
    def self.[](app)
      @app = app
      self
    end

    def self.app
      @app
    end

    def app
      self.class.app
    end
  end
end
