# frozen_string_literal: true

module Forms
  class Errors
    class Populated < Forms::Errors
      def self.for?(errors)
        Array(errors).any?
      end

      def template
        div(class: errors_css_classes) {
          errors.each do |error|
            span(class: error_css_classes) { error }
          end
        }
      end
    end
  end
end
