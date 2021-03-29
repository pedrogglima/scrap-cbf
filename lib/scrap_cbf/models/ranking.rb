# frozen_string_literal: true

class ScrapCbf
  class Ranking
    ATTRS_RANK = %i[
      position
      team
      points
      played
      won
      drawn
      lost
      goals_for
      goals_against
      goal_difference
      yellow_card
      red_card
      advantages
      form
      next_opponent
    ].freeze

    ATTRS_CHAMPIONSHIP = %i[
      championship
      serie
    ].freeze

    TABLE_HEADER = %w[Posição PTS J V E D GP GC SG CA CV % Recentes Próx].freeze

    attr_accessor(*ATTRS_RANK)
    attr_accessor(*ATTRS_CHAMPIONSHIP)

    def to_h
      attrs_acessor.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end

    private

    def attrs_acessor
      (ATTRS_CHAMPIONSHIP + ATTRS_RANK)
    end
  end
end
