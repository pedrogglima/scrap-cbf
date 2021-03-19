# frozen_string_literal: true

class ScrapCbf
  # Outputs data to stdout through kernel#puts.
  # Useful for debugging entities.
  module Printable
    # Outputs data in JSON format
    #
    # @param [Boolean] pretty for use JSON#pretty_generate or not.
    # @return [Nil]
    def print(pretty = true)
      if pretty
        puts JSON.pretty_generate(to_h)
      else
        puts to_json
      end
    end
  end
end
