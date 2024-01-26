# frozen_string_literal: true

module Forms
  module Fields
    class Label
      include Phlex::HtmlRenderable

      def initialize(for_field, text: for_field, **html_options)
        @for_field = for_field
        @text = text
        @css_classes = build_css_classes(html_options.delete(:class))
        @html_options = html_options
      end

      def template
        label(
          for:   for_field,
          class: css_classes,
          **html_options
        ) { text }
      end

      private

      attr_reader :for_field
      attr_reader :text
      attr_reader :html_options

      def css_classes
        default_css_classes + @css_classes
      end

      def build_css_classes(classes)
        Array(classes)
      end

      def default_css_classes
        %w[]
      end
    end
  end
end
