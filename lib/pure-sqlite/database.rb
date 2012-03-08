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
      tables = []
      @schema_page.each_record {|record| tables << record[1].value }
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