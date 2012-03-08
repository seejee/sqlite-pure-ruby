module PureSQLite
  class Header

    STRUCTURE = Structures::BinaryStructure.new(
      well_known_string:         { length: 16, pattern: 'Z16' },
      page_size:                 { length:  2, pattern: 'n'   },
      write_version:             { length:  1, pattern: 'C'   },
      read_version:              { length:  1, pattern: 'C'   },
      page_unused_bytes:         { length:  1, pattern: 'C'   },
      maximum_index_fraction:    { length:  1, pattern: 'C'   },
      minimum_index_fraction:    { length:  1, pattern: 'C'   },
      minimum_table_fraction:    { length:  1, pattern: 'C'   },
      file_change_counter:       { length:  4, pattern: 'N'   },
      database_size:             { length:  4, pattern: 'N'   },
      first_freelist_trunk_page: { length:  4, pattern: 'N'   },
      number_of_free_pages:      { length:  4, pattern: 'N'   },
      schema_version:            { length:  4, pattern: 'N'   },
      schema_layer_file_format:  { length:  4, pattern: 'N'   },
      default_pager_cache_size:  { length:  4, pattern: 'N'   },
      largest_root_page_number:  { length:  4, pattern: 'N'   },
      text_encoding:             { length:  4, pattern: 'N'   },
      user_cookie:               { length:  4, pattern: 'N'   },
      incremental_vacuum_mode:   { length:  4, pattern: 'N'   },
      unused:                    { length: 24, pattern: 'N6'  },
      version_valid_for:         { length:  4, pattern: 'N'   },
      sqlite_version_number:     { length:  4, pattern: 'N'   }
    )

    STRUCTURE.keys.each do |field|
      define_method(field) do
        @header[field]
      end
    end

    def initialize(stream)
      @header = STRUCTURE.parse(stream)
    end

    def length
      STRUCTURE.length
    end

  end
end

