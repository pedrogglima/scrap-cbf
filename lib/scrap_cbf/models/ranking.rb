# frozen_string_literal: true

class ScrapCbf
  class Ranking
    ATTR_ACCESSORS = %i[
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

    TABLE_HEADER = %w[Posição PTS J V E D GP GC SG CA CV % Recentes Próx].freeze

    attr_accessor(*ATTR_ACCESSORS)

    def to_h
      ATTR_ACCESSORS.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
