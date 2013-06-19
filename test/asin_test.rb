require 'test_helper'

class TestASIN < MiniTest::Test
  def test_validates_isbn_like_asins
    File.open('./test/data/isbns').each do |line|
      asin = line.split.first.chomp
      assert ASIN.valid?(asin)
    end
  end

  def test_validates_proprietary_asins
    ASIN.valid?('B000J8VLEC')
  end

  def test_does_not_validate_if_not_10_digits
    refute ASIN.valid?('014310582')
    refute ASIN.valid?('01431058255')
  end

  def test_does_not_validate_if_checksum_not_correct
    refute ASIN.valid?('0143105820')
  end

  def test_converts_to_isbn
    assert_equal '9780143105824', ASIN.to_isbn('0143105825')
  end

  def test_does_not_convert_proprietary_asins
    assert_nil ASIN.to_isbn('B000J8VLEC')
  end

  def test_converts_to_asin
    assert_equal '0143105825', ASIN.from_isbn('9780143105824')
  end
end
