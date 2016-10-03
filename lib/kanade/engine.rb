require 'json'

module Kanade
  class Engine
    @@converters = {}
    @@name_resolvers = {}

    def initialize(configuration=nil)
      @config = configuration || Kanade::Config.default
    end

    def configure
      yield @config
    end

    def serialize(object)
      traverse_field(object).to_json
    end

    def traverse_field(object)
      raise NotSupportedError.new("Serializer only works for Kanade::Dto, and #{object.class.name} does not extend Kanade::Dto") unless object.is_a?(Kanade::Dto)

      result = {}

      object.__fields.each do |field|
        name = field.key_json || name_to_json(field.sym)

        if field.options[:as] == :list
          value = serialize_list(object.send(field.sym), field)
        elsif field.options[:as] == :dto
          value = traverse_field(object.send(field.sym))
        else
          value = field.converter.serialize(object.send(field.sym), field)
        end
        result[name] = value
      end

      result
    end

    def serialize_list(list, field_info)
      return nil if list.nil?
      list.map do |entry|
        if field_info.options[:of].is_a?(Class) and field_info.options[:of] < Dto
          traverse_field(entry)
        else
          conversion_method = field_info.options[:of]
          # TODO how to refer to static field?
          converter = Engine.converter(conversion_method)

          raise NotSupportedError.new("Can not process unknown converter! #{conversion_method}") if converter.nil?

          converter.serialize(entry, field_info)
        end
      end
    end

    def deserialize(definition, json)
      raise NotSupportedError.new("Can not process non-class!") unless definition.is_a?(Class)
      raise NotSupportedError.new("Can not process other than DTO!") unless definition < Dto

      hash = JSON.parse(json)
      deserialize_object(definition, hash)
    end

    # IF engine contains deserialization logic, we can no more
    # unit test the converters. Seems like, the conversion logic
    # must be outsourced to its respective converter
    def deserialize_object(definition, hash)
      return nil if hash.nil?
      result = definition.new
      result.__fields.each do |field|
        name = field.key_json || name_to_json(field.sym)

        if field.options[:as] == :list
          value = deserialize_list(hash[name], field)
        elsif field.options[:as] == :dto
          value = deserialize_object(field.options[:of], hash[name])
        else
          value = hash[name]
        end

        next if value.nil?

        result.send("#{field.key_ruby}=", value)
      end
      result
    end

    def deserialize_list(value, field_info)
      return nil if value.nil?

      # Catatan pribadi: Jadi "of" itu harusnya mengandung field definition?
      # bukan of: Product, tapi of: {as: :dto, of: Product}
      # dengan field definition ini, kita bisa membuat hal yang lebih konfleks, misal:
      # of: {as: :symbol, mapping: {success: 'RES_SUCCESS'}}
      value.map do |v|
        if field_info.options[:of].is_a?(Class) and field_info.options[:of] < Dto
          deserialize_object(field_info.options[:of], v)
        else
          conversion_method = field_info.options[:of]
          # TODO how to refer to static field?
          converter = Engine.converter(conversion_method)

          raise NotSupportedError.new("Can not process unknown converter! #{conversion_method}") if converter.nil?

          converter.deserialize(v, field_info)
        end
      end
    end

    def self.register_converter!(klass)
      key = klass.name.split('::').last.underscore.to_sym

      return if key === :base

      # We don't support multiple converter for now
      raise NotSupportedError.new("#{key} registered twice") if not @@converters[key].nil?

      @@converters[key] = klass.new
    end

    def self.register_name_resolver!(klass)
      key = klass.name.split('::').last.underscore.to_sym

      return if key === :base

      # We don't support multiple converter for now
      raise NotSupportedError.new("#{key} registered twice") if not @@name_resolvers[key].nil?

      @@name_resolvers[key] = klass.new
    end

    def name_to_ruby(string)
      strategy = @config.contract
      @@name_resolvers[strategy].deserialize(string)
    end

    def name_to_json(sym)
      strategy = @config.contract
      @@name_resolvers[strategy].serialize(sym)
    end

    def self.converter(sym)
      @@converters[sym]
    end
  end
end
