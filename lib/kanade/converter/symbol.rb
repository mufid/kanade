module Kanade
  module Converter
    class Symbol < Base
      Engine.register_converter!(self)

      def serialize(term, field_info)
        return nil if term.nil?
        term.to_s
      end

      def deserialize(term, field_info)
        return nil if term.nil?
        return term if term.is_a?(String)
        term.to_s
      end

      configurable :symbol_contract, :camel_case
    end
  end
end
