class Object
  def self.boolean_count(attr)
    define_method("#{attr}_count") do
      instance_variable_get("@#{attr}").count
    end

    define_method("has_#{attr}?") do
      public_send("#{attr}_count").positive?
    end
  end
end
