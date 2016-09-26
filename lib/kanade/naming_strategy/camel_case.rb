module Kanade
  module NamingStrategy
    class CamelCase < Base
      Engine.register_name_resolver!(self)

      def serialize(term)
        ActiveSupport::Inflector.camelize(term, false)
      end
      def deserialize(term)
        term.underscore.to_sym
      end
    end
  end
end
