# frozen_string_literal: true

module Bookland
  class ISBN
    module Calculators
      # @private
      class Calculator
        attr_reader :digits

        def self.calculate(digits)
          new(digits).calculate
        end

        def initialize(digits)
          @digits = digits
        end

        def calculate
          raise 'not implemented'
        end
      end
    end
  end
end
