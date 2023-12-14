# frozen_string_literal: true

class Object
  def subclass_responsibility
    method = caller.first[/.+:in `(\w+)'/, 1]

    raise SubclassResponsibility, "Please implement '#{method}' in subclass: #{self.class}\n on #{caller.first.yellow}"
  end
end

SubclassResponsibility = Class.new(RuntimeError)
