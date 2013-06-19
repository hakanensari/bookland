module Bookland
  class ASIN < Identifier
    WEIGHTS = 10.downto(2).to_a.freeze

    def self.calculate_checksum_digit(digits)
      sum = digits.map(&:to_i).zip(WEIGHTS).reduce(0) { |a , (i, j)| a + i * j }

      case checksum_digit = 11 - sum % 11
      when 0..9 then checksum_digit.to_s
      when 10 then 'X'
      when 11 then '0'
      end
    end

    def self.from_isbn(isbn)
      data_digits = isbn.split('')[3..11]
      checksum_digit = ASIN.calculate_checksum_digit(data_digits)

      (data_digits << checksum_digit).join
    end

    def self.to_isbn(asin)
      return if asin[0] == 'B'

      data_digits = %w(9 7 8) + asin.split('')[0, 9]
      checksum_digit = ISBN.calculate_checksum_digit(data_digits)

      (data_digits << checksum_digit).join
    end

    def valid?
      case digits.first
      when 'B'
        digits.size == 10
      else
        digits.size == 10 && super
      end
    end
  end
end
