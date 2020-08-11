# frozen_string_literal: true

require 'minitest/autorun'

# require 'bookland/isbn'

module Bookland
  class TestISBN < MiniTest::Test
    def setup
      skip
      @isbn = ISBN.new('978-0-330-28498-1')
    end

    def test_gs1_prefix
      assert @isbn.gs1_prefix
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

    def test_conversion
      assert_equal 10, @isbn.isbn10.to_s('').length
    end

    def test_valid
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
  end
end

# require 'helper'
# require 'bookland/isbn/range'

# module Bookland
#   class ISBN
#     # https://en.wikipedia.org/wiki/List_of_ISBN_identifier_groups
#     class TestRange < MiniTest::Test
#       def setup
#         @range = Range.new
#       end

#       def test_message
#         assert @range.message
#       end

#       def test_1_digit_registration_group
#         assert @range.search('9780330284983')
#       end

#       def test_2_digit_registration_group
#         assert @range.search('9788486546087')
#       end

#       def test_3_digit_registration_group
#         assert @range.search('9786001191251')
#       end

#       def test_4_digit_registration_group
#         assert @range.search('9789928400529')
#       end

#       def test_5_digit_registration_group
#         assert @range.search('9789993710561')
#       end

#       def test_no_match
#         assert_nil @range.search('123')
#       end
#     end
#   end
# end
