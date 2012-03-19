module Bookland
  # The now-obsolete 10-digit ISBN.
  class ISBN10 < Identifier
    # Calculates the checksum for the 9-digit payload of an ISBN-10.
    def self.calculate_checksum(payload)
      payload.map! &:to_i
      weights = 10.downto(2).to_a
      sum = payload.zip(weights).inject(0) { |a , (i, j)| a + i * j }
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

      new_payload = [9, 7, 8] +  payload
      new_checksum = ISBN.calculate_checksum new_payload

      (new_payload << new_checksum).join
    end

    def valid?
      @raw.size == 10 && super
    end
  end
end
