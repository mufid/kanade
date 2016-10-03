module Kanade
  module Converter
    class List < Base
      Engine.register_converter!(self)

      def serialize(term, field_info)
        return nil if term.nil?
        term.to_s
      end
      def deserialize(term, field_info)
        return nil if term.nil?
        return term if term.is_a?(BigDecimal)
        ::BigDecimal.new(term)
      end
    end
  end
end
