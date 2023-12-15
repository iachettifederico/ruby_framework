# frozen_string_literal: true

module Components
  class NavBar < Components::ApplicationComponent
    def template
      nav(class: "mb-4 text-black bg-transparent") do
        ul(class: "flex gap-2 border-b") do
          li(class: "shadow-lg hover:shadow-sm") do
            a(href: "/") {
              img(class: "p-1 w-8 h-auto", src: "/public/images/logo.png",
                  alt: "home page")
            }
          end

          item(text: "Pacientes", url: "/patients")

          item(text: "Reset!", url: "/reset") if ENV.fetch("ENVIRONMENT_NAME") == "development"
        end
      end
    end

    private

    def item(text:, url:)
      li(class: "px-2 shadow-lg hover:shadow-sm") do
        a(href: url) { text }
      end
    end
  end
end
