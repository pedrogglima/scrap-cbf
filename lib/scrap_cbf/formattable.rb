# frozen_string_literal: true

class ScrapCbf
  # Format data in standarts outputs
  module Formattable
    # @return [Json]
    def to_json(*_args)
      to_h.to_json
    end

    # @return [Hash]
    def to_h
      raise MethodNotImplementedError
    end
  end
end
