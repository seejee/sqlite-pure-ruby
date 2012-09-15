require "spec_helper"

describe Header do

  let(:io) { open_test_db_stream }
  subject  { Header.new(io) }

  its(:length)                    { should == 100 }
  its(:well_known_string)         { should == "SQLite format 3" }
  its(:write_version)             { should == 1 }
  its(:read_version)              { should == 1 }
  its(:page_unused_bytes)         { should == 0 }
  its(:maximum_index_fraction)    { should == 64 }
  its(:minimum_index_fraction)    { should == 32 }
  its(:minimum_table_fraction)    { should == 32 }
  its(:file_change_counter)       { should == 2 }
  its(:database_size)             { should == 3 }
  its(:first_freelist_trunk_page) { should == 0 }
  its(:number_of_free_pages)      { should == 0 }
  its(:schema_version)            { should == 2 }
  its(:schema_layer_file_format)  { should == 4 }
  its(:default_pager_cache_size)  { should == 0 }
  its(:largest_root_page_number)  { should == 0 }
  its(:text_encoding)             { should == 1 }
  its(:user_cookie)               { should == 0 }
  its(:incremental_vacuum_mode)   { should == 0 }
  its(:version_valid_for)         { should == 2 }

  #its(:sqlite_version_number)     { should == 3007010 }
  #its(:page_size)                 { should == 1024 }
end
