# frozen_string_literal: true

require 'open-uri'
require 'rexml/document'

require 'bookland/isbn/range/message'

module Bookland
  class ISBN
    module Range
      # Loads the ISBN range file generated on The International ISBN Agency
      # website
      #
      # @see https://www.isbn-international.org/range_file_generation
      class Loader
        URL = 'https://www.isbn-international.org/export_rangemessage.xml'
        private_constant :URL

        # @param file [File]
        def initialize(file = generate_file)
          @file = file
        end

        # @return [File]
        def file
          @file.rewind
          @file
        end

        # @return [Message]
        def message
          @message ||= Message.new(document.root)
        end

        private

        def document
          REXML::Document.new(file)
        end

        def generate_file
          URI.open(URL)
        end
      end
    end
  end
end
