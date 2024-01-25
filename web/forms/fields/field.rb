# frozen_string_literal: true

module Forms
  module Fields
    class Field
      include Phlex::HtmlRenderable

      def initialize(name, value: nil, **html_options)
        @name = name
        @value = value
        @css_classes = build_css_classes(html_options.delete(:class))
        @html_options = html_options
      end

      def template
        input(
          name:  name,
          value: value,
          class: css_classes,
          **html_options
        )
      end

      private

      attr_reader :name
      attr_reader :value
      attr_reader :html_options

      def css_classes
        default_css_classes + @css_classes
      end

      def build_css_classes(classes)
        Array(classes)
      end

      def default_css_classes
        %w[p-1 text-gray-800 placeholder:text-gray-400 border rounded]
      end
    end
  end
end
