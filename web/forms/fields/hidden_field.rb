# frozen_string_literal: true

module Forms
  module Fields
    class HiddenField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "hidden"
      end
    end
  end
end
