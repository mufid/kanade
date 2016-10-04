module Kanade
  module Converter
    class Symbol < Base
      Engine.register_converter!(self)

      def serialize(term, field_info)
        return nil if term.nil?
        map = field_info.options[:mapping]
        map_entry = map[term] unless map.nil?
        return map_entry unless map_entry.nil?
        term.to_s.upcase
      end

      def deserialize(term, field_info)
        # TODO WARNING: This is not thread safe!
        # Consider moving this into field definition instead
        build_field_info(field_info) if field_info.options[:mapping_inverted].nil?

        return nil if term.nil?
        inv = field_info.options[:mapping_inverted][term]
        return inv unless inv.nil?

        # TODO use contract!
        term.to_s.downcase.to_sym
      end

      configurable :symbol_contract, :camel_case

      private
        def build_field_info fi
          if fi.options[:mapping].nil?
            inverted = {}
          else
            inverted = fi.options[:mapping].invert
          end

          fi.options[:mapping_inverted] = inverted
        end
    end
  end
end
