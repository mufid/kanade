module Kanade
  class FieldInfo
    def key
      @key
    end

    def key=(term)
      @key = term
    end

    # Set the value of this field. Might
    # be type casted
    def convert(term)
      converter.deserialize(term)
    end

    attr_accessor :converter
    attr_accessor :sym
  end
end
