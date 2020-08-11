# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/range/rule'

module Bookland
  class ISBN
    module Range
      class TestRule < ::MiniTest::Test
        def setup
          file = File.new('./test/data/RangeMessage.xml')
          xpath = 'ISBNRangeMessage/RegistrationGroups/Group/Rules/Rule'
          element = REXML::Document.new(file).get_elements(xpath).sample
          @rule = Rule.new(element)
        end

        def test_length
          assert @rule.length
        end

        def test_range
          assert_kind_of ::Range, @rule.range
        end

        def test_active
          @rule.stub :length, 1 do
            assert @rule.active?
          end
        end

        def test_inactive
          @rule.stub :length, 0 do
            refute @rule.active?
          end
        end

        def test_regexp
          assert_kind_of Regexp, @rule.to_regexp
        end
      end
    end
  end
end
