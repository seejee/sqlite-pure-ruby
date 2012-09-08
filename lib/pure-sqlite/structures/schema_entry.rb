module PureSQLite
  module Structures
    class SchemaEntry
      def initialize(record)
        @record = record
      end

      def type
        record[0].value
      end

      def name
        record[1].value
      end

      def tbl_name
        record[2].value
      end

      def rootpage 
        record[3].value
      end

      def sql 
        record[4].value
      end

      private

      def record
        @record
      end

    end
  end
end

