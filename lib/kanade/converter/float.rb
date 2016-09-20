module Kanade
  module Converter
    class Float < Base
      def serialize(term)
        return nil if term.nil?
        term.to_f
      end
      def deserialize(term)
        return nil if term.nil?
        term.to_f
      end
    end
  end
end
