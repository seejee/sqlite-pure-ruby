require 'spec_helper'

def stub_entry(value)
  record = stub
  record.stub(:value) { value }
  record
end

describe Structures::SchemaEntry do
  context 'a table' do
    let(:record)      { [
        stub_entry('table'),
        stub_entry('some_table'),
        stub_entry('some_table'),
        stub_entry(17),
        stub_entry('CREATE TABLE some_table (id int)')
      ]}
    subject         { Structures::SchemaEntry.new(record) }

    its(:type)      { should == 'table' }
    its(:name)      { should == 'some_table' }
    its(:tbl_name)  { should == 'some_table' }
    its(:rootpage)  { should == 17 }
    its(:sql)       { should == 'CREATE TABLE some_table (id int)' }
  end
end
