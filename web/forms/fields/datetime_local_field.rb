# frozen_string_literal: true

module Forms
  module Fields
    class DatetimeLocalField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "datetime-local"
      end
    end
  end
end
