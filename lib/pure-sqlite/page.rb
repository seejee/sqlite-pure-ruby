module PureSQLite
  class Page

    STRUCTURE = Structures::BinaryStructure.new(
      page_flag:              { length: 1, pattern: 'C' },
      first_available:        { length: 2, pattern: 'n' },
      num_cells:              { length: 2, pattern: 'n' },
      content_start:          { length: 2, pattern: 'n' },
      fragmented_free_bytes:  { length: 1, pattern: 'C' }
    )

    PAGE_FLAGS = {
      0x2 => :index_internal_node,
      0xA => :index_leaf_node,
      0x5 => :table_internal_node,
      0xD => :table_leaf_node,
    }

    STRUCTURE.keys.each do |field|
      define_method(field) do
        @page_header[field]
      end
    end

    attr_reader :number, :cells

    def initialize(header, number, stream)
      @header       = header
      @number       = number
      @page_header  = read_page_header(stream)
      @cells        = read_cells(stream)
    end

    def header_length
      STRUCTURE.length
    end

    def type
      PAGE_FLAGS[page_flag]
    end

    def each_record
      cells.each {|c| yield c.database_record }
    end

    private

    def read_page_header(stream)
      move_to_page_start(stream)
      STRUCTURE.parse(stream)
    end

    def move_to_page_start(stream)
      seek = page_offset
      seek += 100 if @number == 1
      stream.seek(seek, IO::SEEK_SET)
    end

    def page_offset
      @header.page_size * (number - 1)
    end

    def read_cells(stream)
      cells = []
      next_cell_start = page_offset + content_start

      (1..num_cells).each do
        stream.seek(next_cell_start, IO::SEEK_SET)

        cell = Structures::TableCell.new(stream)
        cells << cell

        next_cell_start += cell.total_size
      end

      cells.sort! {|a,b| a.key_value <=> b.key_value }
    end


  end
end