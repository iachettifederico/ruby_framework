# frozen_string_literal: true

RSpec.describe Forms::Form, html: true do
  def build_form_class(&block)
    Class.new do
      include Phlex::HtmlRenderable
      include Forms::Form

      class_eval(&block) if block_given?
    end
  end

  Given(:form_class) {
    build_form_class do
      def template; end
    end
  }
  Given(:form) { form_class.new }
  Given(:html_string) { form.call }

  When(:result) { HTML(html_string) }

  Then {
    result.has_tag?("form")
  }

  pending_context "methods"
  pending_context "actions"
  pending_context "different field types"
  pending_context "form name"
  pending_context "form class"
  pending_context "form id"
  pending_context "html options"
  pending_context ""
  pending_context ""
  pending_context ""
  pending_context ""
  pending_context ""
end
