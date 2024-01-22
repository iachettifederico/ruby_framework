# frozen_string_literal: true

module Components
  class NavBar
    include Phlex::HtmlRenderable
    include Components::ApplicationComponent

    def template
      nav(class: "mb-4 text-slate-50 bg-slate-900") do
        ul(class: "flex gap-2 border-b") do
          li(class: "p-2 shadow-lg hover:shadow-sm") do
            a(href: "/") { "Home" }
          end

          item(text: "Another Link", url: "/") if ENV.fetch("ENVIRONMENT_NAME") == "development"
        end
      end
    end

    private

    def item(text:, url:)
      li(class: "p-2 shadow-lg hover:shadow-sm") do
        a(href: url) { text }
      end
    end
  end
end
