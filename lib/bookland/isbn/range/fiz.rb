# frozen_string_literal: true

require 'structure'

module Bookland
  class ISBN
    module Range
      # Extends `Range` to convert to a `Regexp`
      module Fiz
        refine ::Range do
          def to_regexp
            pattern = ''
            any_digit_count = 0

            first.chars.zip(last.chars).each do |(start_digit, stop_digit)|
              if start_digit == stop_digit
                pattern += start_digit
              elsif start_digit != '0' || stop_digit != '9'
                pattern += "[#{start_digit}-#{stop_digit}]"
              else
                any_digit_count += 1
              end
            end

            pattern += '\d' if any_digit_count.positive?
            pattern += "{#{any_digit_count}}" if any_digit_count > 1

            Regexp.new(pattern)
          end
        end
      end
    end
  end
end
