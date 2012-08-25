require_relative "conversions"

module PureSQLite
  module Structures
    class VariableLengthInteger

      def initialize(stream)
        parse(stream)
      end

      def length
        @length 
      end

      def value
        @value 
      end

      private

      def parse(stream)
        usable_bytes = find_usable_bytes(stream)

        @length = usable_bytes.length
        @value = compute_value(usable_bytes)
      end

      def compute_value(usable_bytes)
        value = usable_bytes.each_with_index.inject(0) do |value, (byte, index)|
          usable_size = ninth?(index) ? 8 : 7

          shifted = value << usable_size
          shifted + usable_value(usable_size, byte)
        end

        Conversions.twos_complement(value) 
      end

      def find_usable_bytes(stream)
        usable = []

        (0..8).each do |counter|
          byte = stream.readbyte
          usable << byte

          break if ninth?(counter) || starts_with_zero?(byte)
        end

        usable
      end

      def ninth?(index)
        index == 8
      end

      IS_FIRST_BIT_ZERO_MASK = 0b10000000
      LAST_SEVEN_BITS_MASK    = 0b01111111

      def starts_with_zero?(byte)
        byte & IS_FIRST_BIT_ZERO_MASK == 0
      end

      def usable_value(usable_size, byte)
        usable_size == 7 ? byte & LAST_SEVEN_BITS_MASK : byte
      end

    end
  end
end
