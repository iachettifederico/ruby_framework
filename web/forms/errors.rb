# frozen_string_literal: true

module Forms
  class Errors
    include Phlex::HtmlRenderable

    def self.for(field_name,
                 errors: [],
                 errors_css_classes: [],
                 error_css_classes: [])
      subclasses.find { |subclass|
        subclass.for?(errors)
      }.new(
        field_name: field_name, errors: errors,
        errors_css_classes: errors_css_classes,
        error_css_classes: error_css_classes,
      )
    end

    private

    attr_reader :errors
    attr_reader :errors_css_classes
    attr_reader :error_css_classes

    def initialize(
      field_name:, errors:,
      errors_css_classes:,
      error_css_classes:
    )
      @errors = Array(errors)
      @errors_css_classes = Array(errors_css_classes)
      @error_css_classes = Array(error_css_classes)
    end
  end
end
