# frozen_string_literal: true

require "roda"

class WebApp < Roda
  plugin :public, root: ROOT.join("web/public").to_s

  route do |r|
    r.root do
      Views::HomePage[self].new.call
    end

    r.on "public" do
      r.public
    end
  end

  # Don't use this method except for tests
  def self.environment=(new_environment)
    @environment = new_environment
  end

  def self.environment
    @environment ||= Environment.current
  end

  private

  def environment
    self.class.environment
  end
end
