# frozen_string_literal: true

require 'set'

module RangeRegexp
  # Converts a numeric Range to Regexp
  #
  # @see https://github.com/ka8725/range_regexp
  class Converter
    attr_reader :min, :max

    def initialize(range)
      @min, @max = range.minmax
    end

    def convert
      Regexp.new(split_to_patterns.join('|'))
    end

    private

    def split_to_patterns
      subpatterns = []
      start = min
      split_to_ranges.each do |stop|
        subpatterns.push(range_to_pattern(start, stop))
        start = stop + 1
      end

      subpatterns
    end

    def split_to_ranges
      stops = Set.new
      stops.add(max)

      nines_count = (min % 10).zero? ? count_nines_at_end(max) + 1 : 1
      stop = fill_by_nines(min, nines_count)
      while min <= stop && stop < max
        stops.add(stop)
        nines_count += 1
        stop = fill_by_nines(min, nines_count)
      end

      zeros_count = 1
      stop = fill_by_zeros(max + 1, zeros_count) - 1
      while min < stop && stop <= max
        stops.add(stop)
        zeros_count += 1
        stop = fill_by_zeros(max + 1, zeros_count) - 1
      end

      stops.sort
    end

    def fill_by_nines(int, nines_count)
      "#{int.to_s[0...-nines_count]}#{'9' * nines_count}".to_i
    end

    def fill_by_zeros(int, zeros_count)
      int - int % 10**zeros_count
    end

    def count_nines_at_end(int)
      int.to_s.match(/(9*$)/).to_s.length
    end

    def range_to_pattern(start, stop)
      pattern = ''
      any_digit_count = 0

      start.to_s.chars.zip(stop.to_s.chars).each do |start_digit, stop_digit|
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

      pattern
    end
  end
end
