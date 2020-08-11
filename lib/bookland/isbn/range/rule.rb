# frozen_string_literal: true

require 'bookland/isbn/range/parsable'

module Bookland
  class ISBN
    module Range
      # Envelopes range length rule for a GS1 prefix or registration group
      # element
      class Rule
        include Parsable

        # @!attribute [r] length
        #   @return [Integer]
        attribute :length do
          element.elements['Length'].text.to_i
        end

        # @!attribute [r] range
        #   @return [Range]
        attribute :range do
          ::Range.new(*element.elements['Range'].text.split('-')
                              .map { |val| val[0, length] })
        end

        # @return [Boolean]
        def active?
          length.positive?
        end

        # @return [Regexp]
        def to_regexp
          RangeRegexp::Converter.new(range).convert
        end
      end
    end
  end
end
