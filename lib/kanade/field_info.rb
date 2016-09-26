module Kanade
  class FieldInfo
    # Set the value of this field. Might
    # be type casted
    def convert(term)
      converter.deserialize(term)
    end

    attr_accessor :converter
    attr_accessor :sym
    attr_accessor :key_json
    attr_accessor :key_ruby
  end
end
