# frozen_string_literal: true

require 'helper'
require 'range_regexp/converter'

module RangeRegexp
  class TestConverter < ::MiniTest::Test
    def test_regexp
      assert_equal /1[2-9]|[2-9]\d|[1-9]\d{2}|[1-2]\d{3}|3[0-3]\d{2}|34[0-4]\d|345[0-6]/, Converter.new(12..3456).convert
      # ensure_correct_conversion(-9..9, /(-[1-9]|\d)/)
      # ensure_correct_conversion(12..3456, )
      # ensure_correct_conversion(-2..0, /(-[1-2]|0)/)
      # ensure_correct_conversion(-3..1, /(-[1-3]|[0-1])/)
      # ensure_correct_conversion(10..39, /([1-3]\d)/)
      # ensure_correct_conversion(11..39, /(1[1-9]|[2-3]\d)/)
      # range = '100'..'397'
      # puts range.to_regexp
    end
  end
end
