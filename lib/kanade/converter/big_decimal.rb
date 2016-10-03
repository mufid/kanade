require 'bigdecimal'

module Kanade
  module Converter
    class BigDecimal < Base
      Engine.register_converter!(self)

      def serialize(term, _)
        return nil if term.nil?
        term.to_s
      end
      def deserialize(term, _)
        return nil if term.nil?
        return term if term.is_a?(BigDecimal)
        ::BigDecimal.new(term)
      end
    end
  end
end
