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

      stacks = []
      result = {}
      stacks += object.__fields

      object.__fields.each do |field|
        name = field.key_json || name_to_json(field.sym)
        value = field.converter.serialize(object.send(field.sym))
        result[name] = value
      end

      result
    end

    def deserialize(definition, json)
      raise NotSupportedError.new("Can not process non-class!") unless definition.is_a?(Class)
      raise NotSupportedError.new("Can not process other than DTO!") unless definition < Dto
      result = definition.new
      raw = JSON.parse json
      result.__fields.each do |field|
        name = field.key_json || name_to_json(field.sym)
        value = raw[name]
        next if value.nil?

        result.send("#{field.key_ruby}=", value)
      end
      result
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
