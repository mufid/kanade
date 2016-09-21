module Kanade
  module Converter
    class Bool < Base
      Engine.register_converter!(self)

      def serialize(term)
        return nil if term.nil?
        term.to_s
      end
      def deserialize(term)
        return nil if term.nil?
        return term if term.is_a?(FalseClass)
        return term if term.is_a?(TrueClass)
        term ? true : false
      end

      def from_string(term)
        term.downcase === 'true'
      end
    end
  end
end
