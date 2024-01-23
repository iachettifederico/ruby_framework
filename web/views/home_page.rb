# frozen_string_literal: true

module Views
  class HomePage
    include Phlex::HtmlRenderable
    include Views::ApplicationView

    def template
      h1(class: "text-slate-800 font-semibold text-xl") { "Home page" }

      p(class: "mx-3 text-slate-600") { "On file #{__FILE__}" }

      p(class: "mx-3 text-slate-600") { "Current time #{Time.now}" }
    end
  end
end
