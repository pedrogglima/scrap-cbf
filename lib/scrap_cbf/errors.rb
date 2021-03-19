# frozen_string_literal: true

class ScrapCbf
  # Base error for all ScrapCbf errors.
  class BaseError < ::StandardError; end

  # Raised when a required method is not implemented.
  class MethodNotImplementedError < BaseError; end

  # Raised when a argument is not included in a predefined range of values.
  class OutOfRangeArgumentError < BaseError
    def initialize(argument, range)
      message = "#{argument} must be in the range of : #{range}"
      super(message)
    end
  end

  # Raised when a argument is required but it is missing.
  class MissingArgumentError < BaseError
    def initialize(argument)
      message = "missing argument: #{argument}"
      super(message)
    end
  end

  # Raised when the scraping data is not included in a predefined range.
  class InvalidNumberOfEntitiesError < BaseError
    def initialize(entity, number)
      message = "an invalid number of #{entity} entities was found: #{number}"
      super(message)
    end
  end

  # Raised when the scraping data from a table
  # have the size of the Table's header different than the Table's rows.
  class RowSizeError < BaseError
    def initialize(row_length, header_length)
      message = "row length: #{row_length} doesn't match with " \
      "header length: #{header_length}"
      super(message)
    end
  end

  # Raised when a method is not found on a class.
  class MethodMissingError < BaseError
    def initialize(klass_name, method)
      message = "method '#{method}' missing on class #{klass_name}"
      super(message)
    end
  end
end
