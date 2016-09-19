module Kanade
  module NamingStrategy
    class CamelCase < Base
      def serialize(term)
        ActiveSupport::Inflector.camelize(term, false)
      end
      def deserialize(term)
        term.underscore.to_sym
      end
    end
  end
end
