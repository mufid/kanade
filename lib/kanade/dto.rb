module Kanade
  class Dto
    class_attribute :__fields
    class_attribute :__definer

    def self.field(name_sym, *options)
      raise NotSupportedError.new('Field must be a symbol!') unless name_sym.is_a?(Symbol)
      raise NotSupportedError.new('Cant use reserved name (__fields)') if name == :__fields

      if self.__definer != self.name
        self.__fields = array_dup(self.__fields) || []
        self.__definer = self.name
      end

      option = options.last

      conversion_method = option[:as]

      if option[:as].is_a?(Class) and option[:as] < Dto
        conversion_method = :dto
        option[:of] = option[:as]
        option[:as] = :dto
      end

      name = name_sym.to_s.freeze
      variable_ref = "@#{name}".freeze
      converter = Engine.converter(conversion_method)
      key_name = option[:with]

      raise Kanade::NotSupportedError.new("Converter #{conversion_method} is not registered") if converter.nil?

      field = FieldInfo.new
      field.converter = converter
      field.key_json = key_name
      field.key_ruby = name
      field.sym = name_sym
      field.options = option

      define_method "#{name}=" do |value|
        instance_variable_set(variable_ref, field.convert(value))
      end

      define_method "#{name}" do
        instance_variable_get(variable_ref)
      end

      self.__fields << field
    end

    private
      def self.array_dup(arr)
        return nil if arr.nil?
        arr.map(&:dup)
      end
  end
end
