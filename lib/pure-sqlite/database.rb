module PureSQLite
  class Database

    def self.open(filename)
      File.open(filename) do |stream|
        db = Database.new(stream)
        if block_given?
          yield db
        else
          return db
        end
      end
    end

    def tables
      schema_entries = @schema_page.records.map { |r| Structures::SchemaEntry.new(r) }
      schema_entries.map { |schema| schema.name }
    end

    def columns(table)
      tables = []
      tables
    end

    private

    def initialize(stream)
      @stream       = stream
      @header       = Header.new(stream)
      @schema_page  = Page.new(@header, 1, stream)
    end

  end
end
