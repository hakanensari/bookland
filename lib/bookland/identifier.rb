module Bookland
  class Identifier
    def self.valid?(raw)
      new(raw).valid?
    end

    def self.calculate_checksum_digit(data_digits)
      raise NotImplementedError
    end

    attr :digits

    def initialize(raw)
      @digits = raw.split('')
    end

    def data_digits
      digits[0...-1]
    end

    def checksum_digit
      digits[-1]
    end

    def to_s
      digits.join
    end

    def valid?
      checksum_digit == recalculate_checksum_digit
    end

    def ==(other)
      to_s == other.to_s
    end

    private

    def recalculate_checksum_digit
      self.class.calculate_checksum_digit(data_digits)
    end
  end
end
