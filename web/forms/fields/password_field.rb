# frozen_string_literal: true

module Forms
  module Fields
    class PasswordField < Field
      include Phlex::HtmlRenderable

      private

      def type
        "password"
      end
    end
  end
end
