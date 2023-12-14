# frozen_string_literal: true

def m(an_object)
  (an_object.methods - Object.new.methods).sort
end

def mm(an_object)
  (an_object.methods - Class.new.methods).sort
end

def mmm(an_object)
  (an_object.methods - Module.new.methods).sort
end
