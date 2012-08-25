require_relative "conversions"

module PureSQLite
  module Structures
    class VariableLengthInteger

      def initialize(stream)
        @result = parse(stream)
      end

      def length
        @result[:length]
      end

      def value
        @result[:value]
      end

      private

      IS_FIRST_BIT_ZERO_MASK = 0b10000000
      LAST_SEVEN_BITS_MASK    = 0b01111111

      def parse(stream)
        value = 0

        (1..9).each do |counter|
          byte = stream.readbyte()

          is_ninth_byte = (counter == 9)

          usable_size = is_ninth_byte ? 8 : 7
          value = value << usable_size
          value += usable_value(usable_size, byte)

          if(is_ninth_byte || starts_with_zero?(byte))
            return {
                length: counter,
                value: Conversions.twos_complement(value)
            }
          end
        end
      end

      def starts_with_zero?(byte)
        byte & IS_FIRST_BIT_ZERO_MASK == 0
      end

      def usable_value(usable_size, byte)
        usable_size == 7 ? byte & LAST_SEVEN_BITS_MASK : byte
      end

    end
  end
end
