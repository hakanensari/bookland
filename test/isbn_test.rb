require 'test_helper'

class TestISBN < MiniTest::Test
  def test_validates
    File.open('./test/data/isbns').each do |line|
      isbn = line.split.last.chomp
      assert ISBN.valid?(isbn)
    end
  end

  def test_does_not_validate_an_ean_that_is_not_a_book
    refute ISBN.valid?('0814916013890')
  end
end
