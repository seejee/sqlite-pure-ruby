require "rspec"
require "spec_helper"

describe Structures::VariableLengthInteger do

  let(:io)    { StringIO.open(bytes) }
  subject     { Structures::VariableLengthInteger.new(io) }

  context "reading a single byte value" do
    let(:bytes) { "\x2b" }

    its(:length) { should == 1 }
    its(:value)  { should == 0x2b }

  end

  context "reading a multiple byte value" do

    let(:bytes) { "\x8c\xA0\x6F" }

    its(:length) { should == 3 }
    its(:value)  { should == 200815 }

  end

  context "reading a -1" do

    let(:bytes) { "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF" }

    its(:length) { should == 9 }
    its(:value)  { should == -1 }

  end

  context "reading a -78506" do

    let(:bytes) { "\xFF\xFF\xFF\xFF\xFF\xFF\xFD\xCD\x56" }

    its(:length) { should == 9 }
    its(:value)  { should == -78506 }

  end

end
