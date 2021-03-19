# frozen_string_literal: true

require_relative 'lib/depth_search'

class ScrapCbf
  module MatchesHelper
    include DepthSearch

    # e.g 0 x 1
    def score_by_team_helper(team, score)
      case team
      when :team
        score.split(' ')[0].to_i if score
      when :opponent
        score.split(' ')[2].to_i if score
      end
    end

    # 03/02/2021 16:00
    def date_with_start_at_helper(date, start_at)
      return unless date && start_at

      "#{date} #{start_at}"
    end

    # teams are extract from <img>
    def scrap_team_names_helper(team_element)
      if team_element.key?('title') &&
         team_element['title'].match?(/^[a-záàâãéèêíïóôõöúç\s]+ - [a-z]{2}$/i)

        # Extract team's name (e.g Santos - SP => Santos)
        team_element['title'][/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
      end
    end

    # Because of problem passing regex, couldn't turn the 5 methods in 1.
    #
    # pass assertive Proc to depth_search
    def find_info_helper(match)
      find = proc do |element|
        if element.text?
          formatted_text = element.text.strip
          unless formatted_text.empty?
            res = formatted_text.match?(
              /Jogo: \d{1,3}$/i
            )
            next formatted_text if res
          end
        end
        nil
      end

      depth_search(match, find)
    end

    # Because of problem passing regex, couldn't turn the 5 methods in 1.
    #
    # pass assertive Proc to depth_search
    def find_updates_helper(match)
      find = proc do |element|
        if element.text?
          formatted_text = element.text.strip
          unless formatted_text.empty?
            res = formatted_text.match?(
              /\d{1} (ALTERAÇÃO|ALTERAÇÕES)$/i
            )
            next formatted_text if res
          end
        end
        nil
      end

      depth_search(match, find)
    end

    # Because of problem passing regex, couldn't turn the 5 methods in 1.
    #
    # pass assertive Proc to depth_search
    def find_start_at_helper(match)
      find = proc do |element|
        if element.text?
          formatted_text = element.text.strip
          unless formatted_text.empty?
            res = formatted_text.match?(
              /^\d{2}:\d{2}$/i
            )
            next formatted_text if res
          end
        end
        nil
      end

      depth_search(match, find)
    end

    # Because of problem passing regex, couldn't turn the 5 methods in 1.
    #
    # pass assertive Proc to depth_search
    def find_score_helper(match)
      find = proc do |element|
        if element.text?
          formatted_text = element.text.strip
          unless formatted_text.empty?
            res = formatted_text.match?(
              /^\d{1} x \d{1}$/i
            )
            next formatted_text if res
          end
        end
        nil
      end

      depth_search(match, find)
    end

    # Because of problem passing regex, couldn't turn the 4 methods in 1.
    #
    # pass assertive Proc to depth_search
    def find_place_helper(match)
      find = proc do |element|
        if element.text?
          formatted_text = element.text.strip
          unless formatted_text.empty?
            res = formatted_text.match?(
              /^[a-záàâãéèêíïóôõöúçñ\-\s]+ - [a-záàâãéèêíïóôõöúçñ\s\-]+ - [A-Z]{2}$/i
            )
            next formatted_text if res
          end
        end
        nil
      end

      depth_search(match, find)
    end
  end
end
