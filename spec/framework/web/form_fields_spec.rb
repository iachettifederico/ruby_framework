# frozen_string_literal: true

RSpec.describe Forms::Fields do
  Given(:html) { field.call }
  Given(:result) { HTML(html) }

  describe Forms::Fields::Field do
    describe "field with name" do
      When(:field) { described_class.new(:field_name) }

      Then { result.has_tag?("input", with: { name: "field_name" }) }
    end

    describe "value attribute" do
      When(:field) { described_class.new(:field_name, value: "field value") }

      Then {
        result.has_tag?("input",
                        with: { name: "field_name", value: "field value" })
      }
    end

    describe "css class attribute" do
      Given(:default_css_classes) {
        %w[p-1 text-gray-800 placeholder:text-gray-400 border rounded]
      }

      When(:field) { described_class.new(:field_name, class: css_class) }

      context "when giving it a simple html class" do
        Given(:css_class) { "a_class"  }

        Then {
          result.has_tag?(
            "input",
            with: {
              class: (default_css_classes + [css_class]).join(" "),
            }
          )
        }
      end

      context "when giving it multiple html classes as a string" do
        Given(:css_class) { "a_class another_class" }

        Then {
          result.has_tag?(
            "input",
            with: {
              class: (default_css_classes + [css_class]).join(" "),
            }
          )
        }
      end

      context "when giving it multiple html classes as an array of strings" do
        Given(:css_class) { %w[a_class another_class] }

        Then {
          result.has_tag?(
            "input",
            with: {
              class: (default_css_classes + css_class).join(" "),
            }
          )
        }
      end

      describe "default css class" do
        When(:field) { described_class.new(:field_name) }

        Then {
          result.has_tag?(
            "input",
            with: {
              class: default_css_classes.join(" "),
            }
          )
        }
      end
    end

    describe "html options" do
      context "adding one html option" do
        When(:field) { described_class.new(:field_name, placeholder: "a placeholder") }

        Then { result.has_tag?("input", with: { placeholder: "a placeholder" }) }
      end

      context "adding multiple html options" do
        When(:field) { described_class.new(:field_name, placeholder: "a placeholder", size: "10") }

        Then { result.has_tag?("input", with: { placeholder: "a placeholder", size: "10" }) }
      end

      context "numeric html option" do
        When(:field) { described_class.new(:field_name, size: 20) }

        Then { result.has_tag?("input", with: { size: "20" }) }
      end
    end
  end

  describe "field types" do
    shared_context "field type" do |type, type_text|
      describe type do
        When(:field) { described_class.new(:my_field_name) }

        Then { result.has_tag?("input", with: { type: type_text }) }
      end
    end

    include_context "field type", Forms::Fields::TextField, "text"
    include_context "field type", Forms::Fields::HiddenField, "hidden"
    include_context "field type", Forms::Fields::HiddenField, "hidden"
    include_context "field type", Forms::Fields::PasswordField, "password"
    include_context "field type", Forms::Fields::NumberField, "number"
    include_context "field type", Forms::Fields::EmailField, "email"
    include_context "field type", Forms::Fields::SearchField, "search"
    include_context "field type", Forms::Fields::DateField, "date"
    include_context "field type", Forms::Fields::DatetimeLocalField, "datetime-local"
    include_context "field type", Forms::Fields::ColorField, "color"
  end

  pending_describe "select"
  pending_describe "button"
  pending_describe "checkbox"
  pending_describe "file"
  pending_describe "image"
  pending_describe "month"
  pending_describe "radio"
  pending_describe "range"
  pending_describe "reset"
  pending_describe "submit"
  pending_describe "tel"
  pending_describe "time"
  pending_describe "url"
  pending_describe "week"
end
