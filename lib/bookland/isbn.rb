module Bookland
  class ISBN < EAN
    PREFIXES = [%w(9 7 8), %w(9 7 9)]

    def valid?
      PREFIXES.include?(digits[0, 3]) && super
    end
  end
end
