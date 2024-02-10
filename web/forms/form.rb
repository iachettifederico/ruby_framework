# frozen_string_literal: true

module Forms
  module Form
    include Phlex::HtmlRenderable

    def initialize(name: "", method: "post", errors: {}, **html_options)
      @http_method = build_http_method(method)
      @css_class = build_css_class(html_options.delete(:class))
      @name = name
      @errors = errors
      @html_options = html_options.transform_values(&:to_s)
    end

    def around_template(&)
      form(
        method: http_method,
        class:  css_class,
        **html_options, &
      )
    end

    def template(*); end

    def http_method?(potential_http_method)
      http_method == potential_http_method.downcase
    end

    def self.included(including_class)
      including_class.extend(ClassMethods)
    end

    def named?(potential_name)
      name == potential_name
    end

    module ClassMethods
      def http_methods
        %w[get post delete patch put head options connect trace]
      end
    end
    extend ClassMethods

    private

    attr_reader :http_method
    attr_reader :html_options
    attr_reader :css_class
    attr_reader :name
    attr_reader :errors

    def build_http_method(an_http_method)
      downcased_http_method = an_http_method.downcase
      raise InvalidHttpMethod, INVALID_HTTP_METHOD unless http_methods.include?(downcased_http_method)

      downcased_http_method
    end

    def build_css_class(some_css_classes)
      [].concat(arrayify_css_classes(some_css_classes))
    end

    def arrayify_css_classes(some_css_classes)
      (
        Array(default_classes) +
        Array(some_css_classes)
      ).join(" ").split
    end

    def http_methods = self.class.http_methods
    def default_classes = []

    def color_field(...)
      render Forms::Fields::ColorField.new(...)
    end

    def date_field(...)
      render Forms::Fields::DateField.new(...)
    end

    def datetime_local_field(...)
      render Forms::Fields::DatetimeLocalField.new(...)
    end

    def email_field(...)
      render Forms::Fields::EmailField.new(...)
    end

    def field(...)
      render Forms::Fields.field.new(...)
    end

    def hidden_field(...)
      render Forms::Fields::HiddenField.new(...)
    end

    def label(...)
      render Forms::Fields::Label.new(...)
    end

    def number_field(...)
      render Forms::Fields::NumberField.new(...)
    end

    def password_field(...)
      render Forms::Fields::PasswordField.new(...)
    end

    def search_field(...)
      render Forms::Fields::SearchField.new(...)
    end

    def select(...)
      render Forms::Fields::Select.new(...)
    end

    def text_field(...)
      render Forms::Fields::TextField.new(...)
    end

    def errors_for(field_name)
      render Forms::Errors.for(
        field_name,
        errors:             errors[field_name],
        errors_css_classes: errors_css_classes,
        error_css_classes:  error_css_classes,
      )
    end

    def errors_css_classes
      []
    end

    def error_css_classes
      []
    end

    def field_wrapper(&)
      div(&)
    end

    InvalidHttpMethod = Class.new(RuntimeError)
    INVALID_HTTP_METHOD = "Invalid HTTP Method"
  end
end
