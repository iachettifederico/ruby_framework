# frozen_string_literal: true

RSpec.configure do |config|
  config.around do |example|
    if %i[request web].include?(RSpec.current_example.metadata[:type])
      RSpec.current_example.metadata[:html] = true
      require "capybara/rspec"

      config.include Capybara::DSL

      Capybara.app = WebApp
      Capybara.default_driver = :rack_test
      Capybara.server = :puma, { Silent: true }

      if RSpec.current_example.metadata.has_key?(:js)
        require "capybara/cuprite"
        Capybara.default_driver = :cuprite
        Capybara.javascript_driver = :cuprite
        Capybara.register_driver(:cuprite) do |app|
          Capybara::Cuprite::Driver.new(
            app,
            # inspector: true,
            window_size:     [1200, 800],
            browser_options: { "no-sandbox": nil },
            timeout:         30,
          )
        end
      end
    end

    example.run
  end
end
