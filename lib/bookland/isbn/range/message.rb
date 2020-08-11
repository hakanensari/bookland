# frozen_string_literal: true

require 'time'

require 'bookland/isbn/range/group'
require 'bookland/isbn/range/parsable'

module Bookland
  class ISBN
    module Range
      # Provides a computer system with the necessary data to split 13-digit
      # ISBNs issued by any national ISBN agency into the segments of an EAN.UCC
      # prefix, a registration group element, a registrant element, a
      # publication element, and a check digit.
      class Message
        include Comparable
        include Parsable

        # @!attribute [r] date
        #   @return [Time]
        attribute :date do
          Time.parse(element.elements['MessageDate'].text)
        end

        # @!attribute [r] serial_number
        #   @return [String]
        attribute :serial_number do
          element.elements['MessageSerialNumber'].text
        end

        # @!attribute [r] source
        #   @return [String]
        attribute :source do
          element.elements['MessageSource'].text
        end

        # @!attribute [r] registration_groups
        #   @return [Array<Group>]
        attribute :registration_groups do
          element.get_elements('RegistrationGroups/Group')
                 .map { |element| Group.new(element) }
        end

        # @return [Regexp]
        def to_regexp
          memo = { '978' => [], '979' => [] }
          registration_groups.each do |group|
            memo[group.gs1_prefix_element] << group.to_regexp
          end

          subpatterns = memo.map do |gs1_prefix_element, regexps|
            "(#{gs1_prefix_element}(#{regexps.join('|')}))"
          end

          Regexp.new("(?:#{subpatterns.join('|')})")
        end

        # @param [Message] other
        # @return [Integer]
        def <=>(other)
          date <=> other.date
        end

        alias to_s serial_number
      end
    end
  end
end
