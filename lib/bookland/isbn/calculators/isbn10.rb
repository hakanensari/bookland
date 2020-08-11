# frozen_string_literal: true

require 'bookland/isbn/calculators/calculator'

module Bookland
  class ISBN
    module Calculators
      # Calculates check digit for an ISBN-10
      #
      # https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-10_check_digit_calculation
      class ISBN10 < Calculator
        WEIGHTS = 10.downto(2).to_a
        private_constant :WEIGHTS

        def calculate
          sum = digits.map(&:to_i)
                      .zip(WEIGHTS)
                      .reduce(0) { |a, (i, j)| a + i * j }
          remainder = (11 - sum % 11) % 11

          remainder == 10 ? 'X' : remainder.to_s
        end
      end
    end
  end
end
