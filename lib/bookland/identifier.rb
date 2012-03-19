module Bookland
  # An abstract unique commercial identifier for a product.
  class Identifier
    def self.calculate_checksum(payload)
      raise NotImplementedError
    end

    def self.valid?(raw)
      new(raw).valid?
    end

    def initialize(raw)
      @raw = raw
    end

    def checksum
      digits[-1]
    end

    def payload
      digits[0...-1]
    end

    def to_s
      @raw
    end

    def valid?
      checksum == self.class.calculate_checksum(payload)
    end

    def ==(other)
      to_s == other.to_s
    end

    private

    def digits
      @digits ||= @raw.split ''
    end
  end
end
