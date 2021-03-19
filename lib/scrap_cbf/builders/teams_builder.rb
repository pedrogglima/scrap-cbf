# frozen_string_literal: true

class ScrapCbf
  class TeamsBuilder
    extend Forwardable
    include TeamsHelper
    include Formattable
    include Printable

    delegate [:each] => :@teams

    def initialize(document)
      @teams = []

      tables = document.css('table')
      table = find_table_by_header(
        tables,
        Ranking::TABLE_HEADER
      )

      scrap_teams(table)
    end

    def to_h
      @teams.map(&:to_h)
    end

    private

    def scrap_teams(table)
      table.css('tbody > tr').each do |tr_element|
        # Remove the rows that are invisible by default
        next if tr_element.element? && element_hidden?(tr_element)

        teams_elements = tr_element.css('img')

        # two teams are found in a row: team and next opponent
        # the last one may be not present
        unless teams_elements.length >= 1 && teams_elements.length <= 2
          raise InvalidNumberOfEntitiesError.new(:team, teams_elements.length)
        end

        # only the first team is scraped
        team_element = teams_elements.first

        @teams << scrap_team(team_element)
      end
    end

    def scrap_team(team_element)
      team = Team.new

      if team_element&.key?('title') &&
         team_element['title'].match?(/^[a-záàâãéèêíïóôõöúç\s]+ - [a-z]{2}$/i)

        scrap_name(team, team_element)
        scrap_state(team, team_element)
        scrap_avatar_url(team, team_element)
      end

      team
    end

    def scrap_name(team, team_element)
      # e.g "Santos"
      team.name = team_element['title'][/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
    end

    def scrap_state(team, team_element)
      # e.g "SP"
      team.state = team_element['title'][/[a-z]{2}$/i]
    end

    def scrap_avatar_url(team, team_element)
      team.avatar_url = team_element['src'] if team_element.key?('src')
    end
  end
end
