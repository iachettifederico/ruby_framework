# frozen_string_literal: true

class Settings
  def load_dirs
    [
      ROOT.join("lib"),
      ROOT.join("web"),
    ]
  end

  def ignore_dirs
    []
  end
end
