module Kanade
  module Converter
    class Bool < Base
      Engine.register_converter!(self)

      def serialize(term, _)
        return nil if term.nil?
        return true if term.is_a?(TrueClass)
        return false if term.is_a?(FalseClass)
        raise NotSupportedError.new("Trying to serialize a bool, but given unknown object")
      end
      def deserialize(term, _)
        return nil if term.nil?
        return term if term.is_a?(FalseClass)
        return term if term.is_a?(TrueClass)
        return from_string(term) if term.is_a?(::String)
        term ? true : false
      end

      def from_string(term)
        term.downcase === 'true'
      end
    end
  end
end
