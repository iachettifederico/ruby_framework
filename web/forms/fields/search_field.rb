# frozen_string_literal: true

module Forms
  module Fields
    class SearchField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "search"
      end
    end
  end
end
