# frozen_string_literal: true

module Forms
  module Fields
    class NumberField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "number"
      end

      def default_options
        { inputmode: "numeric" }
      end
    end
  end
end
