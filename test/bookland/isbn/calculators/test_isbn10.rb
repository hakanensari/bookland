# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/calculators/isbn10'

module Bookland
  class ISBN
    module Calculators
      class TestISBN10 < MiniTest::Test
        def test_calculate
          File.open('./test/data/isbns').each do |line|
            digits = line.split.first.chars
            check_digit = digits.pop
            assert_equal check_digit, ISBN10.calculate(digits)
          end
        end
      end
    end
  end
end
