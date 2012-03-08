module PureSQLite
  module Structures
    class BinaryStructure

      def initialize(hash)
        @hash = hash
      end

      def keys
        @hash.keys
      end

      def values
        @hash.values
      end

      def length
        @hash.values.inject(0) { |sum, opts| sum + opts[:length]}
      end

      def parse(stream)
        hash = {}

        @hash.each do |field, opts|
          field_bytes = stream.read(opts[:length])
          hash[field] = field_bytes.unpack(opts[:pattern]).first
        end

        hash
      end

    end
  end
end