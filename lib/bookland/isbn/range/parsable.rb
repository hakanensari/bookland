# frozen_string_literal: true

require 'structure'

module Bookland
  class ISBN
    module Range
      class Parsable
        include Structure

        # @param element [REXML::Element]
        def initialize(element)
          @element = element
        end

        private

        attr_reader :element
      end
    end
  end
end
