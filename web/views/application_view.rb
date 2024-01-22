# frozen_string_literal: true

module Views
  module ApplicationView
    include Phlex::HtmlRenderable
    include Layouts::ApplicationLayout

    register_element :turbo_frame

    def self.included(including_class)
      including_class.extend(ClassMethods)
    end

    module ClassMethods
      def [](app)
        @app = app
        self
      end

      def app
        @app
      end
    end

    def app
      self.class.app
    end
  end
end
