# frozen_string_literal: true

require "phlex"
require "dry/inflector"

module Components
  class ApplicationComponent < Phlex::HTML
    def self.wrapper_options(new_options = {})
      @wrapper_options ||= {}
      @wrapper_options.merge!(new_options)
      @wrapper_options
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
      component_subpath = full_class_path.gsub(%r{\Acomponent/}, "")
      inflector.dasherize(component_subpath).gsub("/", "-")
    end
  end
end
