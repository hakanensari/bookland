module Bookland
  # The now-obsolete 10-digit ISBN.
  class ISBN10 < Identifier
    # Calculates the checksum for the 9-digit data_digits of an ISBN-10.
    def self.calculate_checksum_digit(data_digits)
      data_digits.map! &:to_i
      weights = 10.downto(2).to_a
      sum = data_digits.zip(weights).inject(0) { |a , (i, j)| a + i * j }
      checksum = 11 - sum % 11

      case checksum
      when 0..9 then checksum.to_s
      when 10 then 'X'
      when 11 then '0'
      end
    end

    # Converts the given ISBN-10 to an ISBN.
    def self.to_isbn(raw)
      new(raw).to_isbn
    end

    # Converts the ISBN-10 to an ISBN.
    def to_isbn
      raise InvalidISBN unless valid?

      new_data_digits = [9, 7, 8] +  data_digits
      new_checksum = ISBN.calculate_checksum_digit new_data_digits

      (new_data_digits << new_checksum).join
    end

    def valid?
      digits.size == 10 && super
    end
  end
end