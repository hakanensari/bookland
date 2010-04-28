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
        ISBN.new(isbn10).valid?.should be_true
      end
    end

    it "should validate ISBN-13s" do
      isbns do |isbn10, isbn13|
        ISBN.new(isbn13).valid?.should be_true
      end
    end

    it "should not validate if seed looks like an ISBN-13 but has an invalid check digit" do
      isbns do |isbn10, isbn13|
        invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
        ISBN.new(invalid).valid?.should be_false
      end
    end

    it "should not validate if seed looks like an ISBN-10 but has an invalid check digit" do
      isbns do |isbn10, isbn13|
        invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
        ISBN.new(invalid).valid?.should be_false
      end
    end

    it "should not validate if seed is not an ISBN" do
      ['foo', 1, '', nil].each { |seed| ISBN.new(seed).valid?.should be_false }
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

    it "should return false if an invalid ISBN is cast as string" do
      ['foo', 1, '', nil].each { |seed| ISBN.new(seed).to_s.should be_false }
    end

    it "should raise an error if an invalid ISBN-13 is converted to ISBN-10" do
      isbns do |isbn10, isbn13|
        invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
        lambda { ISBN.new(invalid).to_isbn10 }.should raise_error ISBNError
      end
    end

    it "should raise an error if an invalid ISBN-10 is converted to ISBN-13" do
      isbns do |isbn10, isbn13|
        invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
        lambda { ISBN.new(invalid).to_isbn13 }.should raise_error ISBNError
      end
    end
  end
end
