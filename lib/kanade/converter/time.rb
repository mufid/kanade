require 'time'

module Kanade
  module Converter
    class Time < Base
      Engine.register_converter!(self)

      def serialize(term, _)
        return nil if term.nil?
        term.iso8601(0)
      end
      def deserialize(term, _)
        return nil if term.nil?
        return term if term.is_a?(Time)
        return term if term.is_a?(Date)
        # WARNING: Parse does not really parse TZ!
        # Consider using ActiveSupport?
        ::Time.parse(term)
      end

      configurable :time_format, :iso8601
      configurable :time_msec_round, 0
    end
  end
end
