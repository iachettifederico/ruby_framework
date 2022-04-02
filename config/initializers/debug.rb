def m(_o_)
  (_o_.methods-Object.new.methods).sort
end

def mm(_o_)
  (_o_.methods-Class.new.methods).sort
end

def mmm(_o_)
  (_o_.methods-Module.new.methods).sort
end
