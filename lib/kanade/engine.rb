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
      object.to_hash.to_json
    end

    def traverse_field(object)
      raise NotSupportedError.new("Serializer only works for Kanade::Dto, and #{object.class.name} does not extend Kanade::Dto") unless object.is_a?(Kanade::Dto)

      stacks = []
      stacks += object.__fields

      object.__fields.each do |k|
      end

    end

    def deserialize(json)
      JSON.parse(json)
      traverse_json(json)
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

    def contract_name_resolver
    end

    def self.converter(sym)
      @@converters[sym]
    end
  end
end
