require "spec_helper"

module Bookland
  describe ISBN do
    it "should convert an ISBN-10 to ISBN-13" do
      isbns do |isbn10, isbn13|
        ISBN.new(isbn10).to_isbn13.should == ISBN.new(isbn13)
      end
    end

    it "should convert an ISBN-13 to ISBN-10" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn13).to_isbn10.should == ISBN.new(isbn10)
       end
     end

     it "should equate ISBN-10 and ISBN-13" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn10).should == ISBN.new(isbn13)
       end
     end

     it "should validate ISBN-10s" do
       isbns do |isbn10, isbn13|
         lambda { ISBN.new(isbn10) }.should_not raise_error
       end
     end

     it "should validate ISBN-13s" do
       isbns do |isbn10, isbn13|
         lambda { ISBN.new(isbn13) }.should_not raise_error
       end
     end

     it "should not validate if seed looks like an ISBN-13 but has an invalid check digit" do
       isbns do |isbn10, isbn13|
         inv = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
         lambda { ISBN.new(inv) }.should raise_error ISBNError
       end
     end

     it "should not validate if seed looks like an ISBN-10 but has an invalid check digit" do
       isbns do |isbn10, isbn13|
         inv = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
         lambda { ISBN.new(inv) }.should raise_error ISBNError
       end
     end

     it "should not validate if seed is not an ISBN" do
       %w{foo 1}.each { |seed| lambda { ISBN.new(seed) }.should raise_error ISBNError }
     end

     it "should not validate if seed is blank" do
       lambda { ISBN.new('') }.should raise_error ISBNError
     end

     it "should not validate if seed is nil" do
       lambda { ISBN.new(nil) }.should raise_error ISBNError
     end

     it "should cast as string" do
       Bookland::ISBN.new('0262011530').to_s.should == '0262011530'
     end

     it "should cast as string and hyphenate an ISBN-13" do
       ISBN.new("9780485113358").to_s(3, 10).should == '978-0485113358'
     end

     it "should cast as string and hyphenate an ISBN-10" do
       ISBN.new("048511335X").to_s(1, 3, 5, 1).should == '0-485-11335-X'
     end
  end
end
