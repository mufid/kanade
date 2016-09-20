module Kanade
  module Converter
    class String < Base
      def serialize(term)
        return nil if term.nil?
        term.to_s
      end
      def deserialize(term)
        return nil if term.nil?
        return term if term.is_a?(String)
        term.to_s
      end
    end
  end
end
