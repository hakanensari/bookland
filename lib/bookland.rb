module Bookland

  # A simple ISBN class
  class ISBN
    def ==(other)
      self.to_isbn13.to_s == other.to_isbn13.to_s
    end

    def initialize(seed=nil)
      self.seed = seed
    end

    def inspect
      to_s
    end

    def seed=(seed)
      @raw = seed.gsub(/[^Xx0-9]/, '').split(//) rescue @raw = []
    end

    def to_isbn10
      raise ISBNError unless valid?

      if isbn13?
        raw = @raw[3..11]
        ISBN.new((raw << check_digit_10(raw)).to_s)
      else
        self.dup
      end
    end

    def to_isbn13
      raise ISBNError unless valid?

      if isbn10?
        raw = @raw[0..8].unshift('9', '7', '8')
        ISBN.new((raw << check_digit_13(raw)).to_s)
      else
        self.dup
      end
    end

    def to_s(*blocks)
      raise ISBNError unless valid?

      raw = @raw.dup
      blocks.any? ? (blocks.map { |i| raw.shift(i).to_s } << raw.to_s).delete_if(&:empty?).join('-') : raw.to_s
    end

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

  # A simple error wrapper for a simple ISBN class
  class ISBNError < StandardError
    def initialize(msg='ISBN not valid')
      super
    end
  end
end
