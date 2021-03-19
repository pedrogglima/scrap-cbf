# frozen_string_literal: true

class ScrapCbf
  class RoundsBuilder
    extend Forwardable
    include Formattable
    include Printable

    delegate [:each] => :@rounds

    def initialize(document)
      @rounds = []

      scrap_rounds(document)
    end

    def matches_builder
      matches = @rounds.reduce([]) do |arr, round|
        matches_per_round = round.matches
        arr.push(*matches_per_round.all)
      end

      MatchesBuilder.new(matches)
    end

    def to_h
      @rounds.map(&:to_h)
    end

    private

    def scrap_rounds(rounds_elements)
      (0..37).each do |round_number|
        round_element = rounds_elements.css(
          "div[data-slide-index=#{round_number}]"
        )

        round_element.children.each do |element|
          next unless element.element? && element.name == 'div'

          round = scrap_round(element, round_number)

          @rounds << round
        end
      end
    end

    def scrap_round(round_element, round_number)
      round = Round.new

      # Because index starts on zero, we add 1 for matching with Rounds ID
      round.number = round_number + 1
      scrap_matches(round, round_element)

      round
    end

    def scrap_matches(round, round_element)
      round_element.children.each do |element|
        # matches are founded on <ul>
        next unless element.element? && element.name == 'ul'

        round.matches = MatchesPerRoundBuilder.new(element, round.number)
      end
      round
    end
  end
end
