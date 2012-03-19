module Bookland
  # An EAN that identifies a book.
  class ISBN < EAN
    # Converts the given ISBN to an ISBN-10.
    def self.to_isbn_10(raw)
      new(raw).to_isbn_10
    end

    # Converts the ISBN to an ISBN-10.
    def to_isbn_10
      raise InvalidISBN unless valid?

      new_payload = payload[3..11]
      new_checksum = ISBN10.calculate_checksum new_payload

      (new_payload << new_checksum).join
    end

    # Whether the ISBN is valid.
    def valid?
      @raw.match(/^97[89]/) && super
    end
  end
end
