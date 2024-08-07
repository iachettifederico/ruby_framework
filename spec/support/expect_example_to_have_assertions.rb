# frozen_string_literal: true

if ENV["EXAMPLES_MUST_HAVE_ASSERTIONS"]
  RSpec.configure do |config|
    config.include(
      Module.new do
      attr_accessor :assertions_have_been_run

      def expect(*)
        self.assertions_have_been_run = true
        super
      end
    end
    )

    config.after do |example|
      unless assertions_have_been_run || example.exception
        no_assertions_error = RuntimeError.new("No assertion run in example '#{example.description}'")
        no_assertions_error.set_backtrace([example.location])
        raise no_assertions_error
      end
    end
  end
end
