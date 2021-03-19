# frozen_string_literal: true

class ScrapCbf
  class Round
    attr_accessor :number,
                  :matches

    def to_h
      {
        number: number,
        matches: matches.to_h
      }.with_indifferent_access
    end
  end
end
