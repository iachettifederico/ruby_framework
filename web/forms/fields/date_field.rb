# frozen_string_literal: true

module Forms
  module Fields
    class DateField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "date"
      end
    end
  end
end
