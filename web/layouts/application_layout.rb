# frozen_string_literal: true

module Layouts
  module ApplicationLayout
    include Phlex::HtmlRenderable

    def around_template
      html do
        head do
          title { "Web App" }
          meta name: "viewport", content: "width=device-width,initial-scale=1"

          link(href: "/public/css/index.css", rel: "stylesheet")

          script(src: "/public/js/index.js")

          script(
            src:         "https://kit.fontawesome.com/c496ff71df.js",
            crossorigin: "anonymous"
          )
        end

        body do
          render Components::NavBar.new

          main(class: "mx-4") do
            yield
          end

          render Components::DevTool.new if ENV.fetch("DEV_TOOL", false)
        end
      end
    end
  end
end
