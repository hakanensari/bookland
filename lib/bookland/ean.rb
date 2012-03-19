module Bookland
  # An International Article Number.
  class EAN < Identifier
    # Calculates the checksum for the 12-digit payload of an EAN.
    def self.calculate_checksum(payload)
      payload.map! &:to_i
      weights = [1, 3] * 6
      sum = payload.zip(weights).inject(0) { |a, (i, j)| a + i * j }

      ((10 - sum % 10) % 10).to_s
    end

    def valid?
      @raw.size == 13 && super
    end
  end
end
