module Bookland
  class EAN < Identifier
    WEIGHTS = ([1, 3] * 6).freeze

    def self.calculate_checksum_digit(digits)
      sum = digits.map(&:to_i).zip(WEIGHTS).reduce(0) { |a, (i, j)| a + i * j }
      ((10 - sum % 10) % 10).to_s
    end

    def valid?
      digits.size == 13 && super
    end
  end
end
