# frozen_string_literal: true

module Views
  class HomePage < View::Layout
    def template
      h1 { "Home page" }
    end
  end
end
