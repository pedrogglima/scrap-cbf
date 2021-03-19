# frozen_string_literal: true

class ScrapCbf
  class Team
    ATTR_ACCESSORS = %i[
      name
      state
      avatar_url
    ].freeze

    attr_accessor(*ATTR_ACCESSORS)

    def to_h
      ATTR_ACCESSORS.each_with_object({}) do |attribute, hash|
        hash[attribute] = send attribute
      end.with_indifferent_access
    end
  end
end
