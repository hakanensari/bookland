# encoding: UTF-8
#
# [Bookland][bl] is a simple ISBN class in Ruby.
#
# [bl]: http://en.wikipedia.org/wiki/Bookland
module Bookland

  #### Public Interface
  #
  # `ISBN.new` takes an optional string. The string should look like an ISBN
  # and may contain extra characters that are traditionally used to format
  # ISBNs.
  #
  # The following are valid instantiations:
  #
  #     isbn13 = ISBN.new('9780826476951')
  #     isbn10 = ISBN.new('0-8264-7695-3')
  #
  #     isbn10 == isbn13
  #     => true
  class ISBN
    class << self

      # Casts a specified string to a 10-digit ISBN.
      def to_10(isbn)
        new(isbn).to_isbn10.to_s
      end

      # Casts a specified string to a 13-digit ISBN.
      def to_13(isbn)
        new(isbn).to_isbn13.to_s
      end

      # Returns `true` if the specified string is a valid ISBN.
      def valid?(isbn)
        new(isbn).valid?
      end
    end

    def initialize(seed=nil)
      self.seed = seed
    end

    # Returns `true` if the ISBN is equal to another specified ISBN.
    def ==(other)
      to_isbn13.to_s == other.to_isbn13.to_s
    end

    # Inspecting an ISBN object will return its string representation.
    def inspect
      to_s
    end

    # Sets the seed of the ISBN based on a specified string.
    def seed=(seed)
      @raw = seed.gsub(/[^Xx0-9]/, '').split(//) rescue @raw = []
    end

    # Casts the ISBN to a ten-digit ISBN.
    def to_isbn10

      raise ISBNError unless valid?

      if isbn13?
        raw = @raw[3..11]
        ISBN.new((raw << check_digit_10(raw)).to_s)
      else
        dup
      end
    end

    def to_isbn13
      raise ISBNError unless valid?

      if isbn10?
        raw = @raw[0..8].unshift('9', '7', '8')
        ISBN.new((raw << check_digit_13(raw)).to_s)
      else
        dup
      end
    end

    # Casts ISBN to a string.
    #
    # Takes an optional list of integers, which it then uses to dashify the
    # ISBN like so:
    #
    #     isbn = ISBN.new('0826476953')
    #     isbn.to_s(1,4,4,1)
    #     => "0-8264-7695-3"
    #
    def to_s(*blocks)
      return false unless valid?

      raw = @raw.dup
      if blocks.any?
        (blocks.map { |i| raw.shift(i).join } << raw.join).delete_if(&:empty?).join('-')
      else
        raw.join
      end
    end

    # Returns `true` if the ISBN is valid.
    def valid?
      if isbn10?
        @raw[9] == check_digit_10(@raw)
      elsif isbn13?
        @raw[12] == check_digit_13(@raw)
      else
        false
      end
    end

    private

    def check_digit_10(raw)
      cd = 11 - 10.downto(2).to_a.zip(raw[0..8].map(&:to_i)).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 11

      case cd
      when 0..9 then cd.to_s
      when 10 then 'X'
      when 11 then '0'
      end
    end

    def check_digit_13(raw)
      ((10 - ([1, 3] * 6).zip(raw[0..11].map(&:to_i)).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 10) % 10).to_s
    end

    def isbn10?
      @raw.length == 10
    end

    def isbn13?
      @raw.length == 13
    end
  end

  class ISBNError < StandardError
    def initialize(msg='Invalid ISBN')
      super
    end
  end
end

# C'est ça.
