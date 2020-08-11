# frozen_string_literal: true

require 'helper'
require 'bookland/isbn/range/message'

module Bookland
  class ISBN
    module Range
      class TestMessage < ::MiniTest::Test
        def setup
          file = File.new('./test/data/RangeMessage.xml')
          element = REXML::Document.new(file).root
          @message = Message.new(element)
        end

        def test_date
          assert_kind_of Time, @message.date
        end

        def test_serial_number
          assert @message.serial_number
        end

        def test_source
          refute_empty @message.source
        end

        def test_registration_groups
          refute_empty @message.registration_groups
        end

        def test_comparison
          mock = Minitest::Mock.new
          mock.expect(:date, @message.date - 1)
          assert @message > mock
        end

        def test_regexp
          assert_kind_of Regexp, @message.to_regexp
        end

        def test_regexp_matches_single_digit_identifier
          # match_data = @message.to_regexp.match('9798602405453')
          isbns = %w[
            979-8-602-40545-3
            978-600-119-125-1
            978-601-7151-13-3
            978-602-8328-22-7
            978-603-500-045-1
            978-606-8126-35-7
            978-607-455-035-1
            978-608-203-023-4
            978-612-45165-9-7
            978-614-404-018-8
            978-615-5014-99-4
            978-616-90393-3-4
            978-617-581-116-0
            978-618-02-0789-7
            978-622-601-101-3
            978-960-99626-7-4
            978-985-6740-48-3
            978-988-00-3827-3
            978-989-758-246-2
            978-9938-01-122-7
            978-9950-974-40-1
            978-99937-1-056-1
            978-99965-2-047-1
            979-10-90636-07-1
            979-11-86178-14-0
            979-12-200-0852-5
            979-8-602-40545-3
          ]
        end
      end
    end
  end
end
