# frozen_string_literal: true

module Forms
  module Form
    include Phlex::HtmlRenderable

    def initialize(method: "post", **html_options)
      @http_method = build_http_method(method)
      @css_class = build_css_class(html_options.delete(:class))
      @html_options = html_options.transform_values(&:to_s)
    end

    def around_template
      form(
        method: http_method,
        class:  css_class,
        **html_options
      )
    end

    def http_method?(potential_http_method)
      http_method == potential_http_method.downcase
    end

    def self.included(including_class)
      including_class.extend(ClassMethods)
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
      ).join(" ").split(" ")
    end

    def http_methods = self.class.http_methods
    def default_classes = []

    InvalidHttpMethod = Class.new(RuntimeError)
    INVALID_HTTP_METHOD = "Invalid HTTP Method"
  end
end
