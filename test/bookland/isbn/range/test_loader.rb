# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/range/loader'

module Bookland
  class ISBN
    module Range
      class TestLoader < ::MiniTest::Test
        def setup
          file = File.new('./test/data/RangeMessage.xml')
          @loader = Loader.new(file)
        end

        def test_file
          assert_kind_of File, @loader.file
        end

        def test_message
          assert_kind_of ISBN::Range::Message, @loader.message
        end
      end
    end
  end
end
