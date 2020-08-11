# frozen_string_literal: true

require 'bookland/isbn/range/parsable'
require 'bookland/isbn/range/rule'

module Bookland
  class ISBN
    module Range
      # Provides data that describes the length of the registrant (publisher)
      # segment of an ISBN within a particular range for a particular
      # registration group element
      class Group
        include Parsable

        # @!attribute [r] agency
        #   @return [String]
        attribute :agency do
          element.elements['Agency'].text
        end

        # @!attribute [r] prefix
        #   @return [String]
        attribute :prefix do
          element.elements['Prefix'].text
        end

        # @!attribute [r] rules
        #   @return [Array<Rule>]
        attribute :rules do
          element.get_elements('Rules/Rule')
                 .map { |element| Rule.new(element) }
        end

        # @return [Regexp]
        def to_regexp
          subpattern = rules.find_all(&:active?).map(&:to_regexp).join('|')
          Regexp.new("(#{identifier_element})(#{subpattern})")
        end

        # @return [String]
        def gs1_prefix_element
          prefix.split('-').first
        end

        # @return [String]
        def identifier_element
          prefix.split('-').last
        end

        alias to_s prefix
      end
    end
  end
end
