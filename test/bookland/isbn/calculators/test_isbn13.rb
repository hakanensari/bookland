# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/calculators/isbn13'

module Bookland
  class ISBN
    module Calculators
      class TestISBN13 < MiniTest::Test
        def test_calculate
          File.open('./test/data/isbns').each do |line|
            digits = line.split.last.chars
            check_digit = digits.pop
            assert_equal check_digit, ISBN13.calculate(digits)
          end
        end
      end
    end
  end
end
