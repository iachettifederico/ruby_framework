# frozen_string_literal: true

RSpec.describe Forms::Form do
  Given(:form_class) {
    Class.new {
      include Phlex::Renderable
      include Forms::Form
    }
  }

  Given(:result) {
    HTML(
      form.call
    )
  }

  describe "empty form" do
    When(:form) { form_class.new }

    Then { result.has_tag?("form") }
  end

  describe "basic attributes" do
    shared_context "method" do |tested_method|
      When(:form) { form_class.new(method: method) }

      context "when the method is #{tested_method.upcase}" do
        Given(:method) { tested_method }

        describe "rendering the form" do
          Then { result.has_tag?("form", with: { method: tested_method }) }
        end

        describe "asserting http methods" do
          context "when the method is lowercase <#{tested_method}>" do
            Then { form.http_method?(tested_method) == true }
            And { form.http_method?(tested_method.upcase) == true }

            (
              Forms::Form.http_methods -
              [tested_method]
            ).each do |potential_method|
              And { form.http_method?(potential_method) == false }
            end
          end

          context "when the method is uppercase <#{tested_method}>" do
            Given(:method) { tested_method.upcase }

            Then { form.http_method?(tested_method) == true }
            And { form.http_method?(tested_method.upcase) == true }

            (
              Forms::Form.http_methods -
              [tested_method]
            ).each do |potential_method|
              And { form.http_method?(potential_method) == false }
            end
          end
        end
      end
    end

    describe "http methods" do
      context "when the http method is not specified" do
        When(:form) { form_class.new }

        Then { form.http_method?("post") == true }
      end

      include_context "method", "get"
      include_context "method", "post"
      include_context "method", "put"
      include_context "method", "head"
      include_context "method", "delete"
      include_context "method", "patch"
      include_context "method", "options"
      include_context "method", "connect"
      include_context "method", "trace"

      context "non-existent method" do
        When(:form) { form_class.new(method: "other") }

        Then { form == Failure(Forms::Form::InvalidHttpMethod, Forms::Form::INVALID_HTTP_METHOD) }
      end
    end

    describe "html options" do
      context "when passing one html option" do
        Given(:action) { "/my_action" }

        When(:form) { form_class.new(action: action) }

        Then { result.has_tag?("form", with: { action: action }) }
      end

      context "when passing multiple html options" do
        Given(:target) { "_blank" }
        Given(:autocomplete) { :on }

        When(:form) {
          form_class.new(
            target:       target,
            autocomplete: autocomplete,
          )
        }

        Then {
          result.has_tag?("form", with: {
                            target:       target,
                            autocomplete: autocomplete.to_s,
                          })
        }
      end
    end

    describe "form class" do
      When(:form) { form_class.new(class: css_class) }

      context "when giving it a simple html class" do
        Given(:css_class) { "a_class" }

        Then { result.has_tag?("form", with: { class: css_class }) }
      end

      context "when giving it multiple html classes as a string" do
        Given(:css_class) { "a_class other_class" }

        Then { result.has_tag?("form", with: { class: css_class }) }
      end

      context "when giving it multiple html classes as an array of strings" do
        Given(:css_class) { %w[a_class other_class] }

        Then { result.has_tag?("form", with: { class: css_class.join(" ") }) }
      end

      describe "default css class" do
        Given(:form_class) {
          Class.new {
            include Phlex::Renderable
            include Forms::Form

            def default_classes
              "my-default-class"
            end
          }
        }

        context "when NOT specifying a class in the initializer" do
          When(:form) { form_class.new }

          Then { result.has_tag?("form", with: { class: "my-default-class" }) }
        end

        context "when specifying a class in the initializer" do
          When(:form) { form_class.new(class: "my-class") }

          Then { result.has_tag?("form", with: { class: "my-default-class my-class" }) }
        end
      end
    end
  end
end
