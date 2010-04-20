require "spec_helper"

describe "Bookland" do
  it "should convert an ISBN-10 to ISBN-13" do
    isbns do |isbn10, isbn13|
      ISBN.new(isbn10).isbn13.should == ISBN.new(isbn13)
    end
  end
  
  it "should convert an ISBN-13 to ISBN-10" do
    isbns do |isbn10, isbn13|
      ISBN.new(isbn13).isbn10.should == ISBN.new(isbn10)
    end
  end
  
  it "should dasherize an ISBN-13" do
    ISBN.new("9780485113358").to_s(3, 10, '-').should == '978-0485113358'
  end
  
  it "should dasherize an ISBN-10" do
    ISBN.new("9780485113358").isbn10.to_s(1, 3, 5, 1, '-').should == '0-485-11335-X'
  end
end