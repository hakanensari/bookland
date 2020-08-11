# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/range/group'

module Bookland
  class ISBN
    module Range
      class TestGroup < ::MiniTest::Test
        def setup
          file = File.new('./test/data/RangeMessage.xml')
          xpath = 'ISBNRangeMessage/RegistrationGroups/Group'
          element = REXML::Document.new(file).get_elements(xpath).sample
          @group = Group.new(element)
        end

        def test_agency
          assert @group.agency
        end

        def test_prefix
          assert @group.prefix
        end

        def test_rules
          refute_empty @group.rules
        end

        def test_regexp
          assert_kind_of Regexp, @group.to_regexp
        end
      end
    end
  end
end
