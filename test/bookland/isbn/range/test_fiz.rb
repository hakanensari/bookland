# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/range/fiz'

module Bookland
  class ISBN
    module Range
      class TestFiz < ::MiniTest::Test
        using Fiz

        def test_regexp
          range = '100'..'397'
          puts range.to_regexp
        end
      end
    end
  end
end
