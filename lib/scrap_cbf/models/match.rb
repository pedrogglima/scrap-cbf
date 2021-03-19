# frozen_string_literal: true

class ScrapCbf
  class Match
    ATTR_ACCESSORS = %i[
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

    attr_accessor(*ATTR_ACCESSORS)

    def to_h
      ATTR_ACCESSORS.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
