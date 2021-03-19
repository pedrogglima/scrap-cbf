# frozen_string_literal: true

class ScrapCbf
  class Championship
    include Formattable
    include Printable

    ATTR_ACCESSORS = %i[
      year
      division
    ].freeze

    attr_accessor(*ATTR_ACCESSORS)

    def initialize(year, division)
      @year = year
      @division = division
    end

    def to_h
      ATTR_ACCESSORS.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
