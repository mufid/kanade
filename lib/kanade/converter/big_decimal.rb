module Kanade
  module Converter
    class BigDecimal < Base
      def serialize(term)
        return nil if term.nil?
        term.to_s
      end
      def deserialize(term)
        return nil if term.nil?
        return term if term.is_a?(BigDecimal)
        BigDecimal.new(term)
      end
    end
  end
end
