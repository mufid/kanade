module Kanade
  module Converter
    class Float < Base
      Engine.register_converter!(self)
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
