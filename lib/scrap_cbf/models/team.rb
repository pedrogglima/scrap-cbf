# frozen_string_literal: true

class ScrapCbf
  class Team
    ATTRS_TEAM = %i[
      name
      state
      avatar_url
    ].freeze

    attr_accessor(*ATTRS_TEAM)

    def to_h
      ATTRS_TEAM.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
