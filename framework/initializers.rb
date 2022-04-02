Dir.new(File.join(ROOT, "config/initializers"))
  .children.sort.each do |name|
  require File.join(ROOT, "config/initializers", name)
end
