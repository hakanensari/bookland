%w(ASIN EAN).each do |klass|
  Object.class_eval <<-EOF
    module ValidationExtensions
      class #{klass.capitalize}Validator < ActiveModel::EachValidator
        def initialize(options)
          options[:message]     ||= "is not a valid #{klass} code"
          options[:allow_nil]   ||= false
          options[:allow_blank] ||= false
          super(options)
        end

        def validate_each(record, attribute, value)
          unless Bookland::#{klass}.valid?(value) || (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])
            record.errors.add(attribute, options[:message])
          end
        end
      end

      module HelperMethods
        def validates_#{klass.downcase}(*attr_names)
          validates_with #{klass.capitalize}Validator, _merge_attributes(attr_names)
        end        
      end
    end
  EOF
end

module ValidationExtensions
  class IsbnValidator < ActiveModel::EachValidator
    def initialize(options)
      options[:message]     ||= "is not a valid ISBN code"
      options[:allow_nil]   ||= false
      options[:allow_blank] ||= false
      options[:compatible] ||= true
      super(options)
    end

    def validate_each(record, attribute, value)
      return if  (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])
      unless Bookland::ISBN.valid?(value) || (options[:compatible] && Bookland::ISBN10.valid?(value))
        record.errors.add(attribute, options[:message])
      end
    end
  end

  module HelperMethods
    def validates_isbn(*attr_names)
      validates_with IsbnValidator, _merge_attributes(attr_names)
    end        
  end  
end

ActiveModel::Validations.send(:include, ValidationExtensions)
ActiveModel::Validations::HelperMethods.send(:include, ValidationExtensions::HelperMethods)

