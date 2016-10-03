module Kanade
  module Converter
    class Float < Base
      Engine.register_converter!(self)
      def serialize(term, _)
        return nil if term.nil?
        term.to_f
      end
      def deserialize(term, _)
        return nil if term.nil?
        return term if term.is_a?(Float)
        term.to_f
      end
    end
  end
end
