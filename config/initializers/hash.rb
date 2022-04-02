class Hash
  def deep_symbolize_keys
    Hash.new.tap { |symbolized_hash|
      each do |k, v|
        symbolized_hash[k.to_sym] = v.is_a?(Hash) ? deep_symbolize_keys(v) : v
      end
    }
  end
end
