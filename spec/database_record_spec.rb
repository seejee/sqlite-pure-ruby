require "spec_helper"

describe DatabaseRecord do

  let(:io)              { open_test_db_stream }
  let(:header)          { Header.new(io) }
  let(:page)            { Page.new(header, 1, io) }
  let(:cell)            { page.cells.first }
  let(:database_record) { cell.database_record }

  after do
    io.close
  end

  context "when reading the first page" do

    subject { database_record }

    its(:total_header_bytes)  { should == 6 }
    its(:entries)             { should have(5).items }

  end

  context "when reading the first entry" do

    subject { database_record.entries[0] }

    its(:type)   { should == :text }
    its(:length) { should == 5 }
    its(:value)  { should == 'table' }

  end

  context "when reading the second entry" do

    subject { database_record.entries[1] }

    its(:type)   { should == :text }
    its(:length) { should == 9 }
    its(:value)  { should == 'table_one' }

  end

  context "when reading the third entry" do

    subject { database_record.entries[2] }

    its(:type)   { should == :text }
    its(:length) { should == 9 }
    its(:value)  { should == 'table_one' }

  end

  context "when reading the fourth entry" do

    subject { database_record.entries[3] }

    its(:type)   { should == :int }
    its(:length) { should == 1 }
    its(:value)  { should == "\x02" }

  end

  context "when reading the fifth entry" do

    subject { database_record.entries[4] }

    its(:type)   { should == :text }
    its(:length) { should == 52 }
    its(:value)  { should == "CREATE TABLE table_one(id int, a_column varchar(20))" }

  end
end
