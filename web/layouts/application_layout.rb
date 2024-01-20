# frozen_string_literal: true

module Layouts
  class ApplicationLayout < Components::ApplicationComponent
    def around_template
      html do
        head do
          title { "Web App" }
          meta name: "viewport", content: "width=device-width,initial-scale=1"

          app.assets_paths(:css).each do |css_path|
            link(href: css_path, rel: "stylesheet")
          end

          app.assets_paths(:js).each do |js_path|
            script(src: js_path)
          end
        end

        body do
          render Components::NavBar.new

          main(class: "mx-4") do
            yield
          end
        end
      end
    end
  end
end
