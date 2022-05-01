RSpec.configure do |config|
  assertions_module = Module.new do
    attr_accessor :assertions_have_been_run

    def expect(*)
      self.assertions_have_been_run = true
      super
    end
  end

  config.include(assertions_module)

  config.after do |example|
    expect(assertions_have_been_run).to(
      eql(true),
      "No assertion run in example '#{example.description}'",
    )
  end
end
