# frozen_string_literal: true

class ScrapCbf
  class Round
    ATTRS_ROUND = %i[
      number
      matches
    ].freeze

    ATTRS_CHAMPIONSHIP = %i[
      championship
      serie
    ].freeze

    attr_accessor(*ATTRS_ROUND)
    attr_accessor(*ATTRS_CHAMPIONSHIP)

    def to_h
      {
        championship: championship,
        serie: serie,
        number: number,
        matches: matches.to_h
      }.with_indifferent_access
    end

    private

    def attrs_acessor
      (ATTRS_CHAMPIONSHIP + ATTRS_ROUND)
    end
  end
end
