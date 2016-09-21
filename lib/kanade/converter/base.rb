module Kanade
  module Converter
    class Base
      puts 'huhuhuhuh'

      # STORED OBJECT --> JSON String
      def serialize(term)
        raise NotSupportedError
      end

      # JSON String / Input object --> Ruby object
      def deserialize(term)
        raise NotSupportedError
      end

    end
  end
end
