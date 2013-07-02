require 'test_helper'

require 'active_model'
require 'bookland/validators'

class TestValidators < MiniTest::Unit::TestCase
  def setup
    @klass = Class.new do
      include ActiveModel::Model
      attr_accessor :attribute
    end
  end

  def test_validates_asin
    @klass.validates(:attribute, asin: true)
    instance = @klass.new
    refute instance.valid?
    instance.attribute = '123'
    refute instance.valid?
    instance.attribute = '0262011530'
    assert instance.valid?
  end

  def test_allows_nil_asin
    @klass.validates(:attribute, asin: true, allow_nil: true)
    instance = @klass.new
    assert instance.valid?
  end

  def test_validates_asin_with_message
    @klass.validates(:attribute, asin: true)#, { message: 'is bad' })
    instance = @klass.new(attribute: '123')
    instance.valid?
    assert_includes instance.errors.first, 'is not an ASIN'
  end

  def test_validates_asin_strictly
    @klass.validates!(:attribute, asin: true)
    instance = @klass.new(attribute: '0262011530')
    assert instance.valid?
    instance.attribute = nil
    instance = @klass.new
    assert_raises(ActiveModel::StrictValidationFailed) { instance.valid? }
  end

  def test_validates_ean
    @klass.validates(:attribute, ean: true)
    instance = @klass.new
    refute instance.valid?
    instance.attribute = '123'
    refute instance.valid?
    instance.attribute = '0814916013890'
    assert instance.valid?
  end

  def test_allows_nil_ean
    @klass.validates(:attribute, ean: true, allow_nil: true)
    instance = @klass.new
    assert instance.valid?
  end

  def test_validates_ean_with_message
    @klass.validates(:attribute, ean: true)#, { message: 'is bad' })
    instance = @klass.new(attribute: '123')
    instance.valid?
    assert_includes instance.errors.first, 'is not an EAN'
  end

  def test_validates_ean_strictly
    @klass.validates!(:attribute, ean: true)
    instance = @klass.new(attribute: '0814916013890')
    assert instance.valid?
    instance.attribute = nil
    assert_raises(ActiveModel::StrictValidationFailed) { instance.valid? }
  end

  def test_validates_isbn
    @klass.validates(:attribute, isbn: true)
    instance = @klass.new
    refute instance.valid?
    instance.attribute = '123'
    refute instance.valid?
    instance.attribute = '9780262011532'
    assert instance.valid?
  end

  def test_allows_nil_isbn
    @klass.validates(:attribute, isbn: true, allow_nil: true)
    instance = @klass.new
    assert instance.valid?
  end

  def test_validates_isbn_with_message
    @klass.validates(:attribute, isbn: true)#, { message: 'is bad' })
    instance = @klass.new(attribute: '123')
    instance.valid?
    assert_includes instance.errors.first, 'is not an ISBN'
  end

  def test_validates_isbn_strictly
    @klass.validates!(:attribute, isbn: true)
    instance = @klass.new(attribute: '9780262011532')
    assert instance.valid?
    instance.attribute = nil
    assert_raises(ActiveModel::StrictValidationFailed) { instance.valid? }
  end
end
