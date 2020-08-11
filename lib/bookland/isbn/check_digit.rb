# frozen_string_literal: true

require 'structure'

require 'bookland/isbn/calculators/isbn10'
require 'bookland/isbn/calculators/isbn13'

module Bookland
  class ISBN
    # An ISBN check digit
    class CheckDigit
      include Structure

      attr_reader :digits

      def initialize(digits)
        @digits = digits
      end

      attribute :given do
        case digits.length
        when 10 then digits[9..-1]
        when 13 then digits[12..-1]
        end
      end

      attribute :calculated do
        case digits.length
        when 9..10 then calculate_for_isbn10
        when 12..13 then calculate_for_isbn13
        end
      end

      def valid?
        given.nil? || given == calculated
      end

      def to_s
        given || calculated if valid?
      end

      private

      def calculate_for_isbn10
        Calculators::ISBN10.calculate(digits.chars[0..8])
      end

      def calculate_for_isbn13
        Calculators::ISBN13.calculate(digits.chars[0..11])
      end
    end
  end
end
