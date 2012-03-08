module PureSQLite
  class DatabaseRecord

    attr_reader :entries

    def initialize(stream)
      @header_index  = Structures::VariableLengthInteger.new(stream)
      @entries       = read_entries(stream)
    end

    def header_index_length
      @header_index.length
    end

    def total_header_bytes
      @header_index.value
    end

    def [](index)
      entries[index]
    end

    private

    def read_entries(stream)
      data = get_entries(stream)
      populate_values(stream, data)
      data
    end

    def populate_values(stream, data)
      data.each do |entry|
        entry.populate_value(stream)
      end
    end

    def get_entries(stream)
      bytes_remaining = total_header_bytes - header_index_length

      entries = []

      until(bytes_remaining == 0)
        entry = Structures::DatabaseRecordEntry.new(stream)
        entries << entry
        bytes_remaining -= entry.header_length
      end

      entries
    end
  end
end