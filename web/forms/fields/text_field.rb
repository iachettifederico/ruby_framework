# frozen_string_literal: true

module Forms
  module Fields
    class TextField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "text"
      end
    end
  end
end
