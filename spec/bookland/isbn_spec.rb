require 'spec_helper'

module Bookland
  describe ISBN do
    describe ".to_10" do
      it "casts a specified string to a ten-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.to_10(isbn10).should eql isbn10
          ISBN.to_10(isbn13).should eql isbn10
        end
      end

      it "raises an ISBNError if the specified string is not a valid ISBN" do
        ['foo', 1, '', nil].each do |isbn|
          expect do
            ISBN.to_10(isbn)
          end.to raise_error ISBNError
        end
      end
    end

    describe ".to_13" do
      it "casts a specified string to a 13-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.to_13(isbn10).should eql isbn13
          ISBN.to_13(isbn13).should eql isbn13
        end
      end

      it "raises an ISBNError if the specified string is not a valid ISBN" do
        ['foo', 1, '', nil].each do |isbn|
          expect do
            ISBN.to_13(isbn)
          end.to raise_error ISBNError
        end
      end
    end

    describe ".valid?" do
      it "returns true if a specified string is a valid ISBN" do
        ISBN.valid?('9780485113358').should be_true
      end

      it "returns false if a specified string is not a valid ISBN" do
        ISBN.valid?('9780485113359').should be_false
      end
    end

    describe "#to_isbn10" do
      it "casts a 10-digit ISBN to a 10-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn10).to_isbn10.should == ISBN.new(isbn10)
        end
      end

      it "casts a 13-digit ISBN to a 10-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn13).to_isbn10.should == ISBN.new(isbn10)
        end
      end

      it "raises an ISBNError if self is not a valid ISBN" do
        isbns do |isbn10, isbn13|
          invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
          expect do
            ISBN.new(invalid).to_isbn10
          end.to raise_error ISBNError
        end
      end
    end

    describe "#to_isbn13" do
      it "casts a 10-digit ISBN to a 13-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn10).to_isbn13.should == ISBN.new(isbn13)
        end
      end

      it "casts a 13-digit ISBN to a 13-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn13).to_isbn13.should == ISBN.new(isbn13)
        end
      end

      it "raises an ISBNError if self is not a valid ISBN" do
        isbns do |isbn10, isbn13|
          invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
          expect do
            ISBN.new(invalid).to_isbn13
          end.to raise_error ISBNError
        end
      end
    end

    describe "#==" do
      it "equates a ten- and a thirteen-digit ISBN" do
        isbns do |isbn10, isbn13|
          (ISBN.new(isbn10) == ISBN.new(isbn13)).should be_true
        end
      end

      it "equates a ten- and a ten-digit ISBN" do
        isbns do |isbn10, isbn13|
          (ISBN.new(isbn10) == ISBN.new(isbn10)).should be_true
        end
      end

      it "equates a thirteen- and a thirteen-digit ISBN" do
        isbns do |isbn10, isbn13|
          (ISBN.new(isbn13) == ISBN.new(isbn13)).should be_true
        end
      end
    end

    describe "#valid?" do
      it "validates a ten-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn10).valid?.should be_true
        end
      end

      it "validates a thirteen-digit ISBN" do
        isbns do |isbn10, isbn13|
          ISBN.new(isbn13).valid?.should be_true
        end
      end

      it "does not validate if the 13-digit seed has an invalid check digit" do
        isbns do |isbn10, isbn13|
          invalid = isbn13.gsub(/(.)$/, "#{(isbn13.split(//).last.to_i - 2) % 10}")
          ISBN.new(invalid).valid?.should be_false
        end
      end

      it "does not validate if the 10-digit seed has an invalid check digit" do
        isbns do |isbn10, isbn13|
          invalid = isbn10.gsub(/(.)$/, "#{(isbn10.split(//).last.to_i - 2) % 10}")
          ISBN.new(invalid).valid?.should be_false
        end
      end

      it "does not validate if seed is not an ISBN" do
        ['foo', 1, '', nil].each { |seed| ISBN.new(seed).valid?.should be_false }
      end
    end

    describe "#to_s" do
      it "casts to string" do
        ISBN.new('0262011530').to_s.should eql '0262011530'
      end

      it "casts to string and hyphenates a thirteen-digit ISBN" do
        ISBN.new('9780485113358').to_s(3, 10).should eql '978-0485113358'
      end

      it "casts to string and hyphenate a ten-digit ISBN" do
        ISBN.new('048511335X').to_s(1, 3, 5, 1).should eql '0-485-11335-X'
      end

      it "returns false if ISBN is not valid" do
        ['foo', 1, '', nil].each { |seed| ISBN.new(seed).to_s.should be_false }
      end
    end
  end
end
