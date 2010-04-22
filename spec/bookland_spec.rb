require "spec_helper"

module Bookland
  describe ISBN do
    
    
    
    it "should cast as string" do
      ISBN.new('0262011530').to_s.should == '0262011530'
    end
    
    it "should cast as string and format" do
      ISBN.new('0262011530').to_s(1, 3, 5).should == '0-262-01153-0'
    end
    
    it "should convert an ISBN-10 to ISBN-13" do
      isbns do |isbn10, isbn13|
        ISBN.new(isbn10).to_isbn13.to_s.should == isbn13
      end
    end
  
    it "should convert an ISBN-13 to ISBN-10" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn13).to_isbn10.to_s.should == isbn10
       end
     end
     
     it "should equate ISBN-10 and ISBN-13" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn10).should == ISBN.new(isbn13)
       end
     end
   
     it "should validate valid ISBN-10s" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn10).valid?.should be_true
       end
     end
   
     it "should validate valid ISBN-13s" do
       isbns do |isbn10, isbn13|
         ISBN.new(isbn13).valid?.should be_true
       end
     end
   
     it "should not validate if seed looks like an ISBN-13 but has an invalid check digit" do
       isbns do |isbn10, isbn13|
         invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 8) % 10}")
         ISBN.new(invalid).valid?.should be_false
       end
     end
   
     it "should not validate if seed looks like an ISBN-10 but has an invalid check digit" do
       isbns do |isbn10, isbn13|
         invalid = isbn10.gsub(/(.)$/, (('0'..'9').to_a + ['X'] - ['\1'])[rand(11)])
         ISBN.new(invalid).valid?.should be_false
       end
     end
   
     it "should not validate if seed is not an ISBN" do
       %w{foo 1}.each { |seed| ISBN.new(seed).valid?.should be_false }
     end
   
     it "should not validate if seed is blank" do
       ISBN.new('').valid?.should be_false
     end
   
     it "should not validate if seed is nil" do
       ISBN.new(nil).valid?.should be_false
     end
   
     it "should hyphenate an ISBN-13" do
       ISBN.new("9780485113358").to_s(3, 10).should == '978-0485113358'
     end
   
     it "should hyphenate an ISBN-10" do
       p ISBN.new("9780485113358").to_isbn10.should == ISBN.new("0-485-11335-X")
       # ISBN.new("9780485113358").to_isbn10.to_s(1, 3, 5, 1).should == '0-485-11335-X'
     end
  end
end