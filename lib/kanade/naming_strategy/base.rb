module Kanade
  module NamingStrategy
    module Base
      def serialize
        raise NotImplementedException
      end
      def deserialize
        raise NotImplementedException
      end
    end
  end
end
