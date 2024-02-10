# frozen_string_literal: true

RSpec.describe Forms::Errors do
  Given(:html) { form.call }
  Given(:result) { HTML(html) }

  Given(:form_class) {
    Class.new {
      include Phlex::Renderable
      include Forms::Form

      def template
        errors_for(:my_field)
      end
    }
  }

  When(:form) { form_class.new(errors: { my_field: field_errors }) }
  When(:form_tag) { result.find_tag(:form) }

  context " when there are NO errors for field" do
    context "when errors for the field is empty" do
      Given(:field_errors) { [] }

      Then { form_tag.empty_element? }
    end

    context "when errors for the field is nil" do
      Given(:field_errors) { nil }

      Then { form_tag.empty_element? }
    end

    context "when there are no errors" do
      Given(:form) { form_class.new(errors: {}) }

      Then { form_tag.empty_element? }
    end

    context "when there are no errors passed in" do
      Given(:form) { form_class.new }

      Then { form_tag.empty_element? }
    end
  end

  context "when the field has errors" do
    context "when there is one error for the field" do
      Given(:field_errors) { "an error" }

      Then { form_tag.has_tag?(:span, text: "an error") }
    end

    context "when there are multiple errors for the field" do |_v|
      Given(:field_errors) { %w[error-one error-two] }

      Then { form_tag.has_tag?(:span, text: "error-one") }
      And { form_tag.has_tag?(:span, text: "error-two") }
    end
  end

  describe "css classes" do
    Given(:form_class) {
      Class.new {
        include Phlex::Renderable
        include Forms::Form

        def template
          errors_for(:my_field)
        end

        private

        def errors_css_classes
          %w[a-class]
        end

        def error_css_classes
          %w[another-class]
        end
      }
    }

    When(:field_errors) { "an-error" }

    Then { form_tag.has_tag?(:div, with: {class: "a-class"}) }
    Then { form_tag.has_tag?(:span, with: {class: "another-class"}) }
  end
end
