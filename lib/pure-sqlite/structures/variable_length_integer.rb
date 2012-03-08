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

      IS_FIRST_BYTE_ZERO_MASK = 0b10000000
      LAST_SEVEN_BITS_MASK    = 0b01111111

      SIGNED_64_BIT_MAX   = 2**63
      UNSIGNED_64_BIT_MAX = 2**64

      def parse(stream)
        counter = 0
        value   = 0

        while(true)
          byte = stream.readbyte()
          counter += 1

          is_ninth_byte = (counter == 9)
          byte_starts_with_zero = (byte & IS_FIRST_BYTE_ZERO_MASK == 0)

          usable_size = is_ninth_byte ? 8 : 7

          if(usable_size == 7)
            byte &= LAST_SEVEN_BITS_MASK
          end

          value = value << usable_size
          value += byte

          if(is_ninth_byte || byte_starts_with_zero)
            break
          end

        end

        {
            length: counter,
            value: twos_complement(value)
        }
      end

      def twos_complement(value)
        if value > SIGNED_64_BIT_MAX
          value - UNSIGNED_64_BIT_MAX
        else
          value
        end
      end

    end
  end
end
