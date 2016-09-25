require 'json'

module Kanade
  class Kanade::Engine
    @@converters = {}

    def initialize(configuration=nil)
      @config = configuration || Kanade::Config.default
    end

    def configure
      yield @config
    end

    def serialize(object)
      object.to_hash.to_json
    end

    def deserialize(object)
    end

    def self.register_converter!(klass)
      key = klass.name.split('::').last.underscore.to_sym

      return if key === :base

      # We don't support multiple converter for now
      raise NotSupportedError.new("#{key} registered twice") if not @@converters[key].nil?

      @@converters[key] = klass.new
    end

    def self.key_from_contract(name)
    end

    def self.converter(sym)
      @@converters[sym]
    end
  end
end
