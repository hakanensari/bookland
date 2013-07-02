require 'test_helper'

class TestIdentifier < MiniTest::Unit::TestCase
  def setup
    @id = Identifier.new('123')
  end

  def test_data_digits
    assert_equal %w(1 2), @id.data_digits
  end

  def test_checksum_digit
    assert_equal '3', @id.checksum_digit
  end

  def test_to_string
    assert_equal '123', @id.to_s
  end

  def test_comparison
    assert_equal Identifier.new('1'), Identifier.new('1')
    refute_equal Identifier.new('1'), Identifier.new('2')
  end

  def test_validation_not_implemented
    assert_raises(NotImplementedError) { Identifier.valid?('123') }
    assert_raises(NotImplementedError) { @id.valid? }
  end

  def test_validator_casts_input_to_string
    assert_raises(NotImplementedError) { Identifier.valid?(nil) }
  end
end
