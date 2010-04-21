module Bookland
  class ISBN
    def initialize(seed)
      @raw = seed.length == 0 ? [] : put_cd(seed.gsub(/[Xx]/, '0').gsub(/[^0-9]/, '').split(//).map { |c| c.to_i })
    end

    def valid?
      false
    end
  
    def to_isbn10
      ISBN.new(by_length(@raw,"put_cd10(@raw[0..9])", "put_cd10(@raw[3..11])").to_s)
    end

    def to_isbn13
      ISBN.new(by_length(@raw, "put_cd13([9,7,8] + @raw[0..8])", "put_cd13(@raw[0..11])").to_s)
    end

    def ==(other)
      self.to_isbn13.to_s == other.to_isbn13.to_s
    end

    def to_s(*blocks)
      return "okj"
      return 1
      if blocks.length == 0
        return put_cd(@raw)
      end
            # 
            # mark = '-'
            # if blocks.length == 0
            #   hyphenate = nil
            # else
            #   case blocks.last
            #     when String then mark = blocks.pop
            #   end
            # end
            # 
            # raw = @raw.dup
            # l = raw.length-1
            # positions = blocks.map_accum.delete_if { |x| x > l || x <= 0 }
            # positions.push l unless positions.last == l || hyphenate.nil?
            # positions.zip(Array.new(raw.length) { |i| i }).map { |i, j| i + j }.each do |b|
            #   raw.insert(b, mark)
            # end
            # raw.inject('') { |i,j| isbnchar(i) + isbnchar(j) }
    end
    
    private
    
    def cd10(raw)
      seed, cd = raw[0..8], raw[9]
      v = 11 - [10, 9, 8, 7, 6, 5, 4, 3, 2].zip(seed).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 11
    end

    def cd13(raw)
      seed, cd = raw[0..11], raw[12]
      v = (10 - [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3].zip(seed).map { |n,m| n * m }.inject(0) { |i,j| i + j } % 10) % 10
    end

    def put_cd10(raw)
      raw[0..8] + [cd10(raw)]
    end

    def put_cd13(raw)
      raw[0..11] + [cd13(raw)]
    end

    def put_cd(raw)
      return "ok"
      by_length(raw, "put_cd10(raw)", "put_cd13(raw)")
    end

    def by_length(raw, do10, do13)
      eval raw.length < 11 ? do10 : do13
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
end

