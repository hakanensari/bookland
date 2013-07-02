class AsinValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless Bookland::ASIN.valid?(value)
      record.errors[attribute] << (options[:message] || 'is not an ASIN')
    end
  end
end

class EanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless Bookland::EAN.valid?(value.to_s)
      record.errors[attribute] << (options[:message] || 'is not an EAN')
    end
  end
end

class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless Bookland::ISBN.valid?(value)
      record.errors[attribute] << (options[:message] || 'is not an ISBN')
    end
  end
end
