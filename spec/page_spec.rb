require "spec_helper"

describe Page do

  context "when reading the first page" do

    let(:io)      { open_test_db_stream }
    let(:header)  { Header.new(io) }
    subject       { Page.new(header, 1, io) }

    after do
      io.close
    end

    its(:first_available)       { should == 0 }
    its(:header_length)         { should == 8 }
    its(:type)                  { should == :table_leaf_node }
    its(:content_start)         { should == 1873 }
    its(:num_cells)             { should == 2 }
    its(:fragmented_free_bytes) { should == 0 }

  end

  context "when reading the first cell" do

    let(:io)      { open_test_db_stream }
    let(:header)  { Header.new(io) }
    subject       { Page.new(header, 1, io).cells[0] }

    after do
      io.close
    end

    its(:record_size) { should == 82 }
    its(:key_value)   { should == 1 }

  end

  context "when reading the second page" do

    let(:io)      { open_test_db_stream }
    let(:header)  { Header.new(io) }
    subject       { Page.new(header, 2, io) }

    after do
      io.close
    end

    its(:first_available) { should == 0 }
    its(:type)            { should == :table_leaf_node }
    its(:content_start)   { should == 2025 }
  end
end