# frozen_string_literal: true

module Forms
  module Fields
    class EmailField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "email"
      end
    end
  end
end
