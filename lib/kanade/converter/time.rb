require 'time'

module Kanade
  module Converter
    class Time < Base
      Engine.register_converter!(self)

      def serialize(term)
        return nil if term.nil?
        term.iso8601(0)
      end
      def deserialize(term)
        return nil if term.nil?
        return term if term.is_a?(Time)
        return term if term.is_a?(Date)
        ::Time.parse(term)
      end

      configurable :time_format, :iso8601
      configurable :time_msec_round, 0
    end
  end
end
