# frozen_string_literal: true

module Views
  class ApplicationView < Layouts::ApplicationLayout
    register_element :turbo_frame

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
