# frozen_string_literal: true

class ScrapCbf
  class Championship
    include Formattable
    include Printable

    ATTR_ACCESSORS = %i[
      year
      serie
    ].freeze

    attr_accessor(*ATTR_ACCESSORS)

    def initialize(year, serie)
      @year = year
      @serie = serie
    end

    def to_h
      ATTR_ACCESSORS.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
