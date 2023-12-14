# frozen_string_literal: true

mobule RSpec
module Core
  class ExampleGroup
    def expect_true(object)
      expect(object).to eql(true)
    end

    def expect_false(object)
      expect(object).to eql(false)
    end
  end
end
