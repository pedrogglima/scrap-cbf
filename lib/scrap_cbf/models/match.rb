# frozen_string_literal: true

class ScrapCbf
  class Match
    ATTRS_MATCH = %i[
      round
      team
      opponent
      id_match
      team_score
      opponent_score
      updates
      date
      start_at
      place
    ].freeze

    ATTRS_CHAMPIONSHIP = %i[
      championship
      serie
    ].freeze

    attr_accessor(*ATTRS_MATCH)
    attr_accessor(*ATTRS_CHAMPIONSHIP)

    def to_h
      attrs_acessor.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end

    private

    def attrs_acessor
      (ATTRS_CHAMPIONSHIP + ATTRS_MATCH)
    end
  end
end
