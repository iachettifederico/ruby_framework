# frozen_string_literal: true

RSpec.describe Forms::Form, html: true do
  pending_context "TODO: eliminate Forms::Form::ClassMethods. It's a buggy implementation because it's saving stuff at the class level"

  def build_form_class(
    name: "",
    action: "",
    http_method: "get",
    css_class: "",
    &block
  )
    Class.new do
      include Phlex::HtmlRenderable
      include Forms::Form

      http_method(http_method)
      action(action)
      css_class(css_class)

      class_eval(&block) if block_given?
    end
  end

  Given(:form_class) {
    build_form_class
  }
  Given(:form) { form_class.new }
  Given(:html_string) { form.call }

  When(:result) { HTML(html_string) }

  describe "empty form" do
    Then { result.has_tag?("form") }
  end

  describe "basic attributes" do
    shared_context "method" do |http_method_to_test|
      Given(:form_class) { build_form_class(http_method: http_method) }

      context "when the method is #{http_method_to_test.upcase}" do
        Given(:expected_method) { http_method_to_test.downcase }
        Given(:expected_upcased_method) { expected_method.upcase }

        Given(:http_method) { http_method_to_test.downcase }
        Given(:uppercase_http_method) { http_method_to_test.upcase }

        context "rendering" do
          Then {
            result.has_tag?(
              "form",
              with: { method: http_method_to_test.downcase }
            )
          }
        end

        context "in lowercase" do
          Then { form.http_method?(expected_method) == true }
          And { form.http_method?(expected_upcased_method) == true }

          (
            %w[get post delete patch put head options connect trace] -
            [http_method_to_test.downcase]
          ).each do |potential_method|
            And { form.http_method?(potential_method) == false }
          end
        end

        context "in uppercase" do
          Given(:form_class) { build_form_class(http_method: uppercase_http_method) }

          Then { form.http_method?(expected_method) == true }
          And { form.http_method?(uppercase_http_method) == true }
        end
      end
    end

    describe "http methods" do
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
        When(:result) { build_form_class(http_method: "other") }

        Then { result == Failure(Forms::Form::InvalidHttpMethod, Forms::Form::INVALID_HTTP_METHOD) }
      end
    end
  end

  describe "action" do
    Given(:form_class) { build_form_class(action: action) }

    context "" do
      let(:action) { "/my_action" }

      Then {
        result.has_tag?(
          "form",
          with: { action: action }
        )
      }
    end
  end

  context "form class" do
    Given(:form_class) { build_form_class(css_class: css_class) }

    context "when passing a single class" do
      let(:css_class) { "a_class" }

      Then {
        result.has_tag?(
          "form",
          with: { class: css_class }
        )
      }
    end

    context "when passing multiple classes as a string" do
      let(:css_class) { "a_class another_class" }

      Then {
        result.has_tag?(
          "form",
          with: { class: css_class }
        )
      }
    end

    context "when passing multiple classes as an array" do
      let(:css_class) { %w[a_class another_class] }

      Then {
        result.has_tag?(
          "form",
          with: { class: css_class.join(" ") }
        )
      }
    end
  end

  pending_context "html options"
  pending_context "target"

  pending_context "form name"
  pending_context "different field types"

  pending_context "form id for model-backed forms"
end
