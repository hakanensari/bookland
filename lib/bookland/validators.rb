%w(ASIN EAN ISBN).each do |klass|
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

ActiveModel::Validations::HelperMethods.send(:include, ValidationExtensions::HelperMethods)
