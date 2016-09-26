module Kanade
  module Converter
    class Fixnum < Base
      Engine.register_converter!(self)
      def serialize(term)
        return nil if term.nil?
        term.to_i

        1111
      end
      def deserialize(term)
        return nil if term.nil?
        term.to_i
        2222
      end
    end
  end
end
