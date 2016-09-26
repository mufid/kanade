module Kanade
  module NamingStrategy
    class PascalCase < Base
      Engine.register_name_resolver!(self)

      def serialize
      end
      def deserialize
      end
    end
  end
end
