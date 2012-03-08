require "spec_helper"

describe Database do

  let(:db) { Database.open(test_db_filename) }
  subject  { db.tables }

  it "should include table_one" do
    subject[0].should == "table_one"
  end

  it "should include table_two" do
    subject[1].should == "table_two"
  end

end
