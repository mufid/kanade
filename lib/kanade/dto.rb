module Kanade
  class Dto
    class_attribute :__fields

    self.__fields = []

    def self.field(name, *options)
      raise NotSupportedException unless name.is_a?(Symbol)
      raise NotSupportedError('Cant use reserved name (__fields)') if name == :__fields

      name = name.to_s.freeze
      variable_ref = "@#{name}".freeze
      option = options.last
      converter = Engine.converter(option[:as])
      key_name = option[:with]

      field = FieldInfo.new
      field.converter = converter
      field.key_json = key_name
      field.key_ruby

      raise NotSupportedError.new("Don't know how to convert #{option[:as]}") if converter.nil?

      define_method "#{name}=" do |value|
        instance_variable_set(variable_ref, field.convert(value))
      end

      define_method "#{name}" do
        instance_variable_get(variable_ref)
      end

      self.__fields << field
    end
  end
end
