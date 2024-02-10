# frozen_string_literal: true

module Forms
  class Errors
    class Empty < Forms::Errors
      def self.for?(errors)
        Array(errors).empty?
      end

      def template; end
    end
  end
end
