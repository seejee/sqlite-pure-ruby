module PureSQLite
  module Structures

    class DatabaseRecordEntry

      SIMPLE_TYPES = {
        0 => {type: :null  , length: 0},
        1 => {type: :int   , length: 1},
        2 => {type: :int   , length: 2},
        3 => {type: :int   , length: 3},
        4 => {type: :int   , length: 4},
        5 => {type: :int   , length: 6},
        6 => {type: :int   , length: 8},
        7 => {type: :float , length: 8},
        8 => {type: :int   , length: 0},
        9 => {type: :int   , length: 0},
      }

      def initialize(stream)
        @header = VariableLengthInteger.new(stream)
        @data   = get_data_type_entry(@header.value)
      end

      def header_length
        @header.length
      end

      def length
        @data[:length]
      end

      def value
        @data[:value]
      end

      def type
        @data[:type]
      end

      def populate_value(stream)
        @data[:value] = get_value(stream)
      end

      private

      def get_data_type_entry(type_value)
        SIMPLE_TYPES[type_value] || get_complex_data_type(type_value)
      end

      def get_complex_data_type(type_value)
        if(type_value.odd? && type_value > 12)
          {type: :text, length: (type_value - 13) / 2}
        else
          {type: :blob, length: (type_value - 12) / 2}
        end
      end

      def get_value(stream)
        bytes = stream.read(length)
        bytes.unpack("A#{length}").first
      end

    end
  end
end