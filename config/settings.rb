# frozen_string_literal: true

class Settings
  def load_dirs
    [
      ROOT.join("lib")
    ]
  end

  def ignore_dirs
    []
  end
end
