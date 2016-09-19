module Kanade
  module NamingStrategy
    class SnakeCase < Base

      configurable :always_upcase do |value|
        false unless value.is_a(FalseClass) or value.is_a(TrueClass)
      end

      def serialize
      end
      def deserialize
      end
    end
  end
end
