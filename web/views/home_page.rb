# frozen_string_literal: true

module Views
  class HomePage < Views::ApplicationView
    def template
      h1 { "Home page" }
    end
  end
end
