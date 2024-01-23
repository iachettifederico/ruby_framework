# frozen_string_literal: true

require "dry/inflector"

# TODO: implement methods and actions

module Forms
  module Form
    include Phlex::HtmlRenderable

    def self.included(including_class)
      super
      including_class.extend(ClassMethods)
    end

    def around_template(&)
      form(
        id:    form_id,
        class: css_class,
        **html_options, &
      )
    end

    module ClassMethods
    end

    def initialize(**html_options)
      super

      @css_class = build_class(html_options.delete(:class))
      @html_options = default_html_options.merge(html_options)
    end

    private

    attr_reader :html_options
    attr_reader :css_class

    def build_class(classes)
      default_css_class.concat(
        arrayfy_classes(classes)
      )
    end

    def default_css_class
      %w[]
    end

    def arrayfy_classes(classes)
      Array(classes).join(" ").split(" ")
    end

    def default_html_options
      {}
    end

    def default_html_options
      {
        autocomplete: true,
        action:       "/",
        method:       "POST",
      }
    end

    def form_id
      inflector = Dry::Inflector.new

      full_class_path = inflector.underscore(self.class.to_s)
      form_subpath = full_class_path.gsub(%r{\Aforms/}, "")

      inflector.dasherize(form_subpath + "-#{model_id}")
    end

    def model_id
      id
    end

    def text_field(...)
      render Forms::Fields::TextField.new(...)
    end

    def hidden_field(...)
      render Forms::Fields::HiddenField.new(...)
    end

    def password_field(...)
      render Forms::Fields::PasswordField.new(...)
    end

    def number_field(...)
      render Forms::Fields::NumberField.new(...)
    end

    def email_field(...)
      render Forms::Fields::EmailField.new(...)
    end

    def search_field(...)
      render Forms::Fields::SearchField.new(...)
    end

    def date_field(...)
      render Forms::Fields::DateField.new(...)
    end

    def datetime_local_field(...)
      render Forms::Fields::DatetimeLocalField.new(...)
    end

    def color_field(...)
      render Forms::Fields::ColorField.new(...)
    end

    def select(...)
      render Forms::Fields::Select.new(...)
    end

    def errors_for(field_name)
      raise NotImplementedError, "Implement 'errors_for'"
    end

    # TODO: implement types
    # <input type="button">
    # <input type="checkbox">
    # <input type="file">
    # <input type="image">
    # <input type="month">
    # <input type="radio">
    # <input type="range">
    # <input type="reset">
    # <input type="submit">
    # <input type="tel">
    # <input type="time">
    # <input type="url">
    # <input type="week">
  end
end
