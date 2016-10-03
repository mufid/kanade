module Kanade
  module Converter
    class List < Base
      Engine.register_converter!(self)

      def serialize(term, field_info)
        return nil if term.nil?
      end
      def deserialize(term, field_info)
        return nil if term.nil?
        #binding.pry unless term.is_a?(Array)
        raise NotSupportedError.new("Value must be array or nil!") unless term.is_a?(Array)

        term.map do |t|
          conversion_method =
            if field_info.options[:of].is_a?(Class) and field_info.options[:of] < Kanade::Dto
              :dto
            else
              field_info.options[:of]
            end

          # Kalau begini caranya, field_info bisa enggak konsisten.
          # Ada yang nyimpen informasinya dirinya sendiri, ada juga
          # yang nyimpen informasi parent-nya.
          converter = Engine.converter(conversion_method)
          binding.pry if converter.nil?
          raise NotSupportedError.new("Unregistered conversion method: #{conversion_method}") if converter.nil?
          converter.deserialize(t, field_info)
        end

      end
    end
  end
end
