require 'test/unit'
require 'isbn'

class TC_ISBN < Test::Unit::TestCase
  def setup
    @sicp = ISBN.new("0262011530")
    @sicp13 = 9780262011532.to_isbn

    @sicpj = 9784894711631.to_isbn
  end

  def test_sicp
    assert_equal(@sicp13, @sicp.isbn13)
  end
  def test_sicpj
    assert_equal("4 89471 163 X", @sicpj.isbn10.to_s(1,5,3," "))
  end
end

