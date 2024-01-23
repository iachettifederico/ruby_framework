# frozen_string_literal: true

module Forms
  module Fields
    class Field
      include Phlex::HtmlRenderable

      def initialize(name, **html_options)
        @name = name
        @css_class = build_class(html_options.delete(:class))
        @value = html_options.delete(:value)
        @html_options = default_html_options.merge(html_options)
      end

      def template
        input(
          value: value,
          type:  type,
          name:  name,
          class: css_class,
          **html_options
        )
      end

      private

      attr_reader :name
      attr_reader :value
      attr_reader :html_options
      attr_reader :css_class

      def build_class(classes)
        default_css_class.concat(
          arrayfy_classes(classes)
        )
      end

      def default_css_class
        %w[p-1 text-gray-800 placeholder:text-gray-400 border rounded]
      end

      def arrayfy_classes(classes)
        Array(classes).join(" ").split(" ")
      end

      def default_html_options
        {}
      end
    end
  end
end