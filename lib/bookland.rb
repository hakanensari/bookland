module Bookland
  
  # most methods take an Array containing ISBN digits.
  # 'cd' means 'check digit'.

  def cd10(raw)
    seed, cd = raw[0..8], raw[9]
    v = 11 - [10,9,8,7,6,5,4,3,2].zip(seed).map { |n,m| n * m }.inject(0) { |i,j| i+j } % 11
  end

  def cd13(raw)
    seed, cd = raw[0..11], raw[12]
    v = (10 - [1,3,1,3,1,3,1,3,1,3,1,3].zip(seed).map { |n,m| n * m }.inject(0){ |i,j| i+j } % 10) % 10
  end

  def put_cd10(raw)
    raw[0..8] + [cd10(raw)]
  end

  def put_cd13(raw)
    raw[0..11] + [cd13(raw)]
  end

  def put_cd(raw)
    by_length(raw, "put_cd10(raw)", "put_cd13(raw)")
  end

  def to_isbn(raw)
    by_length(raw, "cd10(raw)", "cd13(raw)")
  end

  def by_length(raw, do10, do13)
    if raw.length < 11
      eval do10
    else
      eval do13
    end
  end

  def isbnchar(i) # needed only for ISBN-10
    case i
    when String then i
    when 0..9 then i.to_s
    when 10 then 'X'
    when 11 then '0'
    else '*'
    end
  end
end

class String
  def isbn_string
    gsub(/[Xx]/, '0').gsub(/[^0-9]/, '')
  end

  def to_isbn
    ISBN.new(self)
  end
end

class Integer
  def digit(base)
    n, c = self, 0
    n, c = n/base, c+1 while n >= 1
    return c
  end

  # Integer -> ISBN
  def to_isbn
    ISBN.new(self)
  end
end

class Array
  include Bookland
  
  def to_isbn
    inject('') { |i,j| isbnchar(i) + isbnchar(j) }.to_isbn
  end
  
  def map_accum
    raw = []
    each_index { |i| raw << self[0..i].inject(0) { |n,m| n+m } }
    return raw
  end
end

class ISBN
  include Bookland
  attr_accessor :raw

  def initialize(*seed)
    if seed.length == 0
      @raw
    else
      case seed[0]
        when String then d,s = seed[0].length, seed[0].isbn_string.to_i
        when Integer then d,s = seed[0].digit(10), s = seed[0]
      end
      @raw = put_cd(Array.new(d <= 10 ? 10 : 13) { |i| 10**i }.reverse.map { |ord| s / ord % 10 })
    end
  end

  def inspect
    raw ? raw.inject('') { |i,j| isbnchar(i) + isbnchar(j) } : false
  end

  # ISBN -> ISBN
  def to_isbn10
    raw = self.raw
    by_length(raw,
              "put_cd10(raw[0..9])",
              "put_cd10(raw[3..11])").to_isbn
  end
  def to_isbn13
    raw = self.raw
    by_length(raw,
              "put_cd13([9,7,8] + raw[0..8])",
              "put_cd13(raw[0..11])").to_isbn
  end

  def ==(other)
    self.isbn13.to_s == other.isbn13.to_s
  end

  # ISBN -> String
  def to_s(*blocks)
    mark = '-'
    if blocks.length == 0
      hyphenate = nil
    else
      case blocks.last
        when String then mark = blocks.pop
      end
    end

    raw = self.raw.dup
    l = raw.length-1
    positions = blocks.map_accum.delete_if { |x| x > l || x <= 0 }
    positions.push l unless positions.last == l || hyphenate.nil?
    positions.zip(Array.new(raw.length) { |i| i }).map{|i,j| i+j}.each do |b|
      raw.insert(b, mark)
    end
    raw.inject('') { |i,j| isbnchar(i) + isbnchar(j) }
  end
end

