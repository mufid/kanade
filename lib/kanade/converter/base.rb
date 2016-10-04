module Kanade
  module Converter
    class Base
      # TODO use module.included
      # Engine.register_converter!(self)

      # STORED OBJECT --> JSON String
      def serialize(term, field_info)
        raise NotSupportedError
      end

      # JSON String / Input object --> Ruby object
      def deserialize(term, field_info)
        raise NotSupportedError
      end

      def self.configurable(name, default)
      end

    end
  end
end
