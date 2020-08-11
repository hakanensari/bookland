# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/check_digit'

module Bookland
  class ISBN
    class TestCheckDigit < MiniTest::Test
      def test_validation_for_isbn10
        check_digit = CheckDigit.new('0802409431')
        assert check_digit.valid?
      end

      def test_validation_for_isbn10_with_no_check_digit
        check_digit = CheckDigit.new('080240943')
        assert check_digit.valid?
      end

      def test_validation_for_isbn10_with_incorrect_check_digit
        check_digit = CheckDigit.new('0802409432')
        refute check_digit.valid?
      end

      def test_validation_for_isbn13
        check_digit = CheckDigit.new('9780802409430')
        assert check_digit.valid?
      end

      def test_validation_for_isbn13_with_no_check_digit
        check_digit = CheckDigit.new('978080240943')
        assert check_digit.valid?
      end

      def test_validation_for_isbn13_with_incorrect_check_digit
        check_digit = CheckDigit.new('9780802409431')
        refute check_digit.valid?
      end
    end
  end
end
