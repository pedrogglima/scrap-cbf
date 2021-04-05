# frozen_string_literal: true

class ScrapCbf
  class MatchesPerRoundBuilder
    extend Forwardable
    include MatchesHelper
    include Formattable
    include Printable

    delegate %i[each map] => :@matches

    attr_reader :matches
    alias all matches

    def initialize(matches_elements, round_number, championship)
      @championship = championship
      @matches = []

      scrap_matches(matches_elements, round_number)
    end

    def to_h
      @matches.map(&:to_h)
    end

    private

    def scrap_matches(matches_elements, round_number)
      matches_elements.children.each do |match_element|
        next unless match_element.element?

        @matches << scrap_match(match_element, round_number)
      end
    end

    def scrap_match(match_element, round_number)
      match = Match.new
      match.championship = @championship.year
      match.serie = @championship.serie

      match.round = round_number

      # e.g "Qua, 03/02/2021 16:00 - Jogo: 336"
      scrap_info(match, match_element)
      # e.g <img title="team-name">
      scrap_teams(match, match_element)
      # e.g "1 alteração" (can be undefined)
      scrap_update(match, match_element)
      # e.g "16:00" (can be found in two places, we take only the first)
      scrap_start_at(match, match_element)
      # e.g "1 x 1" (can be undefined)
      scrap_score(match, match_element)
      # e.g "Vila Belmiro - Santos - SP" (can be undefined)
      scrap_place(match, match_element)

      match
    end

    def scrap_info(match, match_element)
      info = find_info_helper(match_element)
      return unless info

      # e.g "Jogo: 336" (always defined)
      match.id_match = info[/Jogo: \d{1,3}$/i].gsub(/^Jogo: /, '')
      # e.g "03/02/2021" (can be undefined)
      match.date = info[%r{\d{2}/\d{2}/\d{2,4}}i]
      # e.g "16:00" (can be undefined)
      match.start_at = info[/\d{2}:\d{2}/i]
    end

    def scrap_place(match, match_element)
      match.place = find_place_helper(match_element)
    end

    def scrap_score(match, match_element)
      score = find_score_helper(match_element)

      match.team_score = score_by_team_helper(:team, score)
      match.opponent_score = score_by_team_helper(:opponent, score)
    end

    def scrap_update(match, match_element)
      match.updates = find_updates_helper(match_element)
    end

    def scrap_teams(match, match_element)
      teams_elements = match_element.css('img')

      unless teams_elements.length == 2
        raise InvalidNumberOfEntitiesError.new(:team, teams_elements.length)
      end

      teams_name = teams_elements.map do |team_element|
        next unless team_element.element?

        scrap_team_names_helper(team_element)
      end

      unless teams_name.length == 2
        raise InvalidNumberOfEntitiesError.new(:team, teams_name.length)
      end

      match.team = teams_name[0]
      match.opponent = teams_name[1]
    end

    def scrap_start_at(match, match_element)
      match.start_at = find_start_at_helper(match_element) unless match.start_at
      datetime = date_with_start_at_helper(match.date, match.start_at)
      match.date = datetime if datetime
    end
  end
end
