require "spec_helper"

describe Database do

  let(:db) { Database.open(test_db_filename) }
  subject  { db.tables }

  its([0]) { should == "table_one"}
  its([1]) { should == "table_two"}

end