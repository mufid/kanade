module Kanade
  class Dto
    class_attribute :__fields

    self.__fields = []

    def self.field(name, *options)
      raise NotSupportedException unless name.is_a?(Symbol)
      raise NotSupportedError('Cant use reserved name (__fields)') if name == :__fields

      name = name.to_s
      option = options.last
      converter = Engine.converter(option[:as])

      raise NotSupportedError.new("Don't know how to convert #{option[:as]}") if converter.nil?

      define_method "#{name}=" do |value|
        value = converter.deserialize(value)
        instance_variable_set("@#{name}", value)
      end

      define_method "#{name}" do
        instance_variable_get("@#{name}")
      end

      self.__fields << name
    end
  end
end
