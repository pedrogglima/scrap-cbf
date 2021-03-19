# frozen_string_literal: true

class ScrapCbf
  class MatchesBuilder
    extend Forwardable
    include Formattable
    include Printable

    delegate %i[each map] => :@matches

    attr_accessor :matches

    def initialize(matches)
      @matches = matches
    end

    def to_h
      @matches.map(&:to_h)
    end
  end
end
