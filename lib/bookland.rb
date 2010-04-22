module Bookland
  class ISBN
    def initialize(seed)
      @raw = seed.gsub(/[^Xx0-9]/, '').split(//) rescue @raw = []
      raise ISBNError unless valid?
    end
    
    def inspect
      to_s
    end

    def to_isbn10
      if isbn13?
        raw = @raw[3..11]
        ISBN.new((raw << cd10(raw)).to_s)
      else
        self.dup
      end
    end

    def to_isbn13
      if isbn10?
        raw = @raw[0..8].unshift('9', '7', '8')
        ISBN.new((raw << cd13(raw)).to_s)
      else
        self.dup
      end
    end

    def ==(other)
      self.to_isbn13.to_s == other.to_isbn13.to_s
    end

    def to_s(*blocks)
      raw = @raw.dup
      blocks.any? ? (blocks.map { |i| raw.shift(i).to_s } << raw.to_s).delete_if(&:empty?).join('-') : raw.to_s
    end

    private

    def cd10(raw)
      cd = 11 - [10, 9, 8, 7, 6, 5, 4, 3, 2].zip(raw[0..8].map(&:to_i)).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 11
      case cd
      when 0..9 then cd.to_s
      when 10 then 'X'
      when 11 then '0'
      end
    end

    def cd13(raw)
      ((10 - [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3].zip(raw[0..11].map(&:to_i)).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 10) % 10).to_s
    end

    def isbn10?
      @raw.length == 10
    end

    def isbn13?
      @raw.length == 13
    end

    def valid?
      if isbn10?
        @raw[9] == cd10(@raw)
      elsif isbn13?
        @raw[12] == cd13(@raw)
      else
        false
      end
    end
  end

  class ISBNError < StandardError
    def initialize(msg='ISBN not valid')
      super
    end
  end
end
