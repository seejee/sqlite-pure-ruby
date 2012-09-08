require "spec_helper"

describe Page do

  let(:io)      { open_test_db_stream }
  let(:header)  { Header.new(io) }

  context "when reading the first page" do

    subject       { Page.new(header, 1, io) }

    its(:first_available)       { should == 0 }
    its(:header_length)         { should == 8 }
    its(:type)                  { should == :table_leaf_node }
    its(:content_start)         { should == 849 }
    its(:num_cells)             { should == 2 }
    its(:fragmented_free_bytes) { should == 0 }

    after do
      io.close
    end

  end

  context "when reading the first cell" do

    subject       { Page.new(header, 1, io).cells[0] }

    its(:record_size) { should == 82 }
    its(:key_value)   { should == 1 }

    after do
      io.close
    end

  end

  context "when reading the second page" do

    subject       { Page.new(header, 2, io) }

    its(:first_available) { should == 0 }
    its(:type)            { should == :table_leaf_node }
    its(:content_start)   { should == 1024 }

    after do
      io.close
    end

  end
end
