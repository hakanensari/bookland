# frozen_string_literal: true

require 'bookland/isbn/calculators/calculator'

module Bookland
  class ISBN
    module Calculators
      # Calculates check digit for an ISBN-13
      #
      # https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-13_check_digit_calculation
      class ISBN13 < Calculator
        WEIGHTS = ([1, 3] * 6)
        private_constant :WEIGHTS

        def calculate
          sum = digits.map(&:to_i)
                      .zip(WEIGHTS)
                      .reduce(0) { |a, (i, j)| a + i * j }

          ((10 - sum % 10) % 10).to_s
        end
      end
    end
  end
end
