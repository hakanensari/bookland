$:.push File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'bookland'

include Bookland

module Test::Unit::Assertions
  def assert_false(object, message = '')
    assert_equal false, object, message
  end
end

class TestIdentifier < Test::Unit::TestCase
  def setup
    @id = Identifier.new '123'
  end

  def test_checksum
    assert_equal '3', @id.checksum
  end

  def test_payload
    assert_equal ['1', '2'], @id.payload
  end

  def test_comparison
    assert Identifier.new('1') == Identifier.new('1')
    assert Identifier.new('1') != Identifier.new('2')
  end
end

class TestEAN < Test::Unit::TestCase
  def test_validates_an_ean
    assert EAN.valid? '0814916013890'
  end

  def test_does_not_validate_if_not_13_digits
    assert_false EAN.valid?('978082647694')
    assert_false EAN.valid?('97808264769444')
  end

  def test_does_not_validate_if_checksum_not_correct
    assert_false EAN.valid?('9780826476940')
  end
end

class TestISBN < Test::Unit::TestCase
  def test_validates_isbns
    File.open(File.expand_path('../isbns', __FILE__)).each do |line|
      isbn = line.split.last.chomp
      assert ISBN.valid? isbn
    end
  end

  def test_does_not_validate_an_ean_that_is_not_a_book
    assert_false ISBN.valid?('0814916013890')
  end

  def test_converts_to_isbn_10
    isbn = ISBN.new '9780143105824'
    assert_equal '0143105825', isbn.to_isbn_10
  end

  def test_raises_error_when_converting_invalid_isbn
    isbn = ISBN.new '9780143105820'
    assert_raise InvalidISBN do
      isbn.to_isbn_10
    end
  end
end

class TestISBN10 < Test::Unit::TestCase
  def test_validates_isbn_10s
    File.open(File.expand_path('../isbns', __FILE__)).each do |line|
      isbn10 = line.split.first.chomp
      assert ISBN10.valid? isbn10
    end
  end

  def test_converts_to_isbn
    isbn10 = ISBN10.new '0143105825'
    assert_equal '9780143105824', isbn10.to_isbn
  end

  def test_raises_error_when_converting_invalid_isbn10
    isbn10 = ISBN10.new '0143105820'
    assert_raise InvalidISBN do
      isbn10.to_isbn
    end
  end

  def test_does_not_validate_if_not_13_digits
    assert_false EAN.valid?('014310582')
    assert_false EAN.valid?('01431058255')
  end

  def test_does_not_validate_if_checksum_not_correct
    assert_false EAN.valid?('0143105820')
  end
end
