# frozen_string_literal: true

module Components
  class DevTool
    include Phlex::HtmlRenderable
    include Components::ApplicationComponent

    def template
      div(
        class: css_classes, draggable: "true",
        data: {
          controller: "dev-tool",
          action:     "dragend->dev-tool#dragEnd",
        }
      ) {
        h1(class: %w[font-semibold border-b] + border_color) { "Dev Tool" }

        nav(class: "m-2") {
          a(href: "/") { "HomePage" }
        }
      }
    end

    private

    def css_classes
      [
        css_position,
        css_spacing,
        css_sizing,
        css_color,
      ].flatten.compact
    end

    def css_position
      %w[absolute top-0 left-0 z-50]
    end

    def css_spacing
      %w[p-2]
    end

    def css_sizing
      %w[text-xs]
    end

    def css_color
      %w[bg-purple-50 text-purple-800 border-2] + border_color
    end

    def border_color
      %w[border-purple-900]
    end
  end
end
