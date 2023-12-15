# frozen_string_literal: true

module Layouts
  class ApplicationLayout < View::ApplicationView
    def around_template
      html do
        head do
          title do "Pacientes" end
          meta name: "viewport", content: "width=device-width,initial-scale=1"
          app.assets_paths(:css).each do |css_path|
            link(href: css_path, rel: "stylesheet")
          end
        end

        body do
          render Component::NavBar.new
          main(class: "mx-4") do
            yield
          end
        end
      end
    end
  end
end
