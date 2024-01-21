# frozen_string_literal: true

require "phlex"
require "dry/inflector"

module Components
  module ApplicationComponent
    include Phlex::HtmlRenderable

    def self.included(including_class)
      super
      including_class.extend(ClassMethods)
    end

    module ClassMethods
      def wrapper_options(new_options = {})
        @wrapper_options ||= {}
        @wrapper_options.merge!(new_options)
        @wrapper_options
      end
    end

    private

    def around_template(&)
      component_wrapper(**self.class.wrapper_options, &)
    end

    def component_wrapper(**, &)
      div(component: component_name, **, &)
    end

    def component_name
      inflector = Dry::Inflector.new
      full_class_path = inflector.underscore(self.class.to_s)
      component_subpath = full_class_path.gsub(%r{\Acomponents/}, "")
      inflector.dasherize(component_subpath).gsub("/", "-")
    end
  end
end
