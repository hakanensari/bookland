require 'test_helper'

class TestEAN < MiniTest::Unit::TestCase
  def test_validates
    assert EAN.valid?('0814916013890')
  end

  def test_does_not_validate_if_not_13_digits
    refute EAN.valid?('978082647694')
  end

  def test_does_not_validate_if_checksum_incorrect
    refute EAN.valid?('9780826476940')
  end
end
