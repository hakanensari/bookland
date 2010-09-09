require "spec_helper"

module Bookland
  describe Bookland::ISBN do
    context "class methods" do
      it "converts to ISBN-10" do
        isbns do |isbn10, isbn13|
          Bookland::ISBN.to_10(isbn10).should eql isbn10
          Bookland::ISBN.to_10(isbn13).should eql isbn10
        end
      end

      it "converts to ISBN-13" do
        isbns do |isbn10, isbn13|
          Bookland::ISBN.to_13(isbn10).should eql isbn13
          Bookland::ISBN.to_13(isbn13).should eql isbn13
        end
      end

      it "raises an ISBNError if an invalid ISBN is converted" do
        ['foo', 1, '', nil].each do |isbn|
          lambda { Bookland::ISBN.to_10(isbn)}.should raise_error Bookland::ISBNError
          lambda { Bookland::ISBN.to_13(isbn)}.should raise_error Bookland::ISBNError
        end
      end

      it "validates an ISBN" do
        Bookland::ISBN.valid?("9780485113358").should be_true
        Bookland::ISBN.valid?("9780485113359").should be_false
      end
    end

    it "converts an ISBN-10 to ISBN-13" do
      isbns do |isbn10, isbn13|
        Bookland::ISBN.new(isbn10).to_isbn13.should == Bookland::ISBN.new(isbn13)
      end
    end

    it "converts an ISBN-13 to ISBN-10" do
      isbns do |isbn10, isbn13|
        Bookland::ISBN.new(isbn13).to_isbn10.should == Bookland::ISBN.new(isbn10)
      end
    end

    it "equates ISBN-10 and ISBN-13" do
      isbns do |isbn10, isbn13|
        (Bookland::ISBN.new(isbn10) == Bookland::ISBN.new(isbn13)).should be_true
      end
    end

    it "validates ISBN-10s" do
      isbns do |isbn10, isbn13|
        Bookland::ISBN.new(isbn10).valid?.should be_true
      end
    end

    it "validates ISBN-13s" do
      isbns do |isbn10, isbn13|
        Bookland::ISBN.new(isbn13).valid?.should be_true
      end
    end

    it "does not validate if seed looks like an ISBN-13 but has an invalid check digit" do
      isbns do |isbn10, isbn13|
        invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
        Bookland::ISBN.new(invalid).valid?.should be_false
      end
    end

    it "does not validate if seed looks like an ISBN-10 but has an invalid check digit" do
      isbns do |isbn10, isbn13|
        invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
        Bookland::ISBN.new(invalid).valid?.should be_false
      end
    end

    it "does not validate if seed is not an ISBN" do
      ['foo', 1, '', nil].each { |seed| Bookland::ISBN.new(seed).valid?.should be_false }
    end

    it "casts as string" do
      Bookland::ISBN.new('0262011530').to_s.should eql '0262011530'
    end

    it "casts as string and hyphenate an ISBN-13" do
      Bookland::ISBN.new("9780485113358").to_s(3, 10).should eql '978-0485113358'
    end

    it "casts as string and hyphenate an ISBN-10" do
      Bookland::ISBN.new("048511335X").to_s(1, 3, 5, 1).should eql '0-485-11335-X'
    end

    it "returns false if an invalid ISBN is cast as string" do
      ['foo', 1, '', nil].each { |seed| Bookland::ISBN.new(seed).to_s.should be_false }
    end

    it "raises an ISBNError if an invalid ISBN-13 is converted to ISBN-10" do
      isbns do |isbn10, isbn13|
        invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
        lambda { Bookland::ISBN.new(invalid).to_isbn10 }.should raise_error Bookland::ISBNError
      end
    end

    it "raises an ISBNError if an invalid ISBN-10 is converted to ISBN-13" do
      isbns do |isbn10, isbn13|
        invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
        lambda { Bookland::ISBN.new(invalid).to_isbn13 }.should raise_error Bookland::ISBNError
      end
    end
  end
end
