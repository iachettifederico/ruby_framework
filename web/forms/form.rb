# frozen_string_literal: true

module Forms
  module Form
    include Phlex::HtmlRenderable

    def initialize(method: "post", **html_options)
      @http_method = get_http_method(method)
      @html_options = html_options.transform_values(&:to_s)
    end

    def around_template
      form(method: http_method, **html_options)
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

    def get_http_method(an_http_method)
      downcased_http_method = an_http_method.downcase
      raise InvalidHttpMethod, INVALID_HTTP_METHOD unless http_methods.include?(downcased_http_method)

      downcased_http_method
    end

    def http_methods
      self.class.http_methods
    end

    InvalidHttpMethod = Class.new(RuntimeError)
    INVALID_HTTP_METHOD = "Invalid HTTP Method"
  end
end
