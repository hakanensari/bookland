# frozen_string_literal: true

require 'minitest/autorun'
# require 'bookland/isbn'

module Bookland
  class TestISBN10 < MiniTest::Test
    def setup
      skip
      @isbn = ISBN.new('0-330-28498-3')
    end

    def test_gs1_prefix
      assert_empty @isbn.gs1_prefix
    end

    def test_agency_element
      assert @isbn.agency_element
    end

    def test_publisher_element
      assert @isbn.publisher_element
    end

    def test_publication_element
      assert @isbn.publication_element
    end

    def test_check_digit
      assert @isbn.check_digit
    end

    def test_agency
      assert @isbn.agency
    end

    def test_to_s
      assert @isbn.to_s
    end

    def test_to_s_with_separator
      assert @isbn.to_s(' ').include?(' ')
    end

    def test_validation
      assert @isbn.valid?
    end

    def test_bad_format
      isbn = ISBN.new('97-0-330-28498-3')
      refute isbn.valid?
    end

    def test_unmatched_element
      isbn = ISBN.new('978-9-330-28498-1')
      refute isbn.valid?
    end

    def test_invalid_check_digit
      isbn = ISBN.new('978-0-330-28498-3')
      refute isbn.valid?
    end

    # def test_isbn10
    #   range = ISBN.new('1788160916')
    #   assert_equal '1-788-160916-6', range.to_s
    # end
  end
end
