module Kanade
  module NamingStrategy
    class Base
      ##
      # Ruby --> JSON
      def serialize(term)
        raise NotImplementedException
      end
      ##
      # JSON --> Ruby
      def deserialize(term)
        raise NotImplementedException
      end

      def self.configurable(name)
        # Do nothing for now
      end
    end
  end
end
