# frozen_string_literal: true

module Forms
  module Fields
    class Select < Field
      # TODO: I want to use this like:
      # select(:field_name) do |select|
      #   select.option(text: "do", value: "yes", default: true)
      #   select.option(text: "don't", value: "no")
      # end
      # For this I need to create Forms::Fields::Option and the Forms::Fields::Select#option method

      include Phlex::HtmlRenderable

      def initialize(name, options: [], **html_options)
        @options = Array(options)
        super(name, **html_options)
      end

      def template
        select(value: value, name: name, class: css_class, **html_options) do
          options.each do |option_text, option_value|
            option(value: option_value) { option_text }
          end
        end
      end

      private

      attr_reader :options

      def type
        "number"
      end

      def default_options
        { inputmode: "numeric" }
      end
    end
  end
end
