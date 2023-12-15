# frozen_string_literal: true

guard "livereload" do
  extensions = {
    css:  :css,
    scss: :css,
    sass: :css,
    js:   :js,
    html: :html,
    png:  :png,
    gif:  :gif,
    jpg:  :jpg,
    jpeg: :jpeg,
  }

  rails_view_exts = %w[rb]

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})
  watch(%r{app/javascript/.+\.(#{compiled_exts * '|'})})
  watch(%r{app/assets/stylesheets/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/routes\.rb})
  watch(%r{config/locales/.+\.yml})
end
