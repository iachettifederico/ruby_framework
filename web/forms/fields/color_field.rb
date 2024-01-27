# frozen_string_literal: true

module Forms
  module Fields
    class ColorField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "color"
      end
    end
  end
end
