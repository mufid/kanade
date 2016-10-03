module Kanade
  module Converter
    class Dto < Base
      Engine.register_converter!(self)

      def serialize(term, field_info)
        term
      end

      def deserialize(term, field_info)
        return nil if term.nil?
        raise NotSupportedError.new('DTO-based field only can be filled with nil / respective DTO object') unless term.is_a?(field_info.options[:of])
        return term
      end
    end
  end
end
