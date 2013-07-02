%w(ASIN EAN ISBN).each do |klass|
  Object.class_eval <<-EOF
    class #{klass.capitalize}Validator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        return if value.nil? && options[:allow_nil]

        unless Bookland::#{klass}.valid?(value)
          message = "is not an #{klass}"
          if options[:strict]
            raise ActiveModel::StrictValidationFailed, "\#{value} \#{message}"
          else
            record.errors[attribute] << message
          end
        end
      end
    end
  EOF
end
