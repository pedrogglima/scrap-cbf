# frozen_string_literal: true

class ScrapCbf
  class RankingsBuilder
    extend Forwardable
    include RankingsHelper
    include Formattable
    include Printable

    delegate [:each] => :@rankings

    def initialize(document, championship)
      @championship = championship
      @rankings = []
      @header = []
      @rows   = []

      tables = document.css('table')
      table = find_table_by_header(tables, Ranking::TABLE_HEADER)

      return unless table

      scrap_rankings(table)
    end

    def to_h
      @rankings.map(&:to_h)
    end

    private

    def scrap_rankings(table)
      scrap_header(table)
      scrap_body(table)
      create_rankings_from_table
    end

    def scrap_header(table)
      table.css('thead > tr > th').each do |th|
        text = th.element? && remove_whitespace(th)
        next unless text

        title = title_or_nil_helper(th)

        @header << HeaderColumn.new(text, title)
      end
    end

    def scrap_body(table)
      table.css('tbody > tr').each do |tr_element|
        next if tr_element.element? && element_hidden?(tr_element)

        row = Row.new
        tr_element.children.each do |td_element|
          text = td_element.element? && remove_whitespace(td_element)

          next unless text

          text = scrap_position_if_exist(text)

          team = scrap_team_name_if_exist(td_element)

          # First cell (e.g posicao: 7º and team: Fluminense)
          if text && !text.empty? && team && !team.empty?
            row.cells << Cell.new(text)
            row.cells << Cell.new(team)
          elsif team && !team.empty?
            row.cells << Cell.new(team)
          else
            row.cells << Cell.new(text)
          end
        end

        # Add 1 to header length because on first cell we scrap 2 values
        row_length = row.cells.length
        header_length = @header.length + 1
        unless row_length == header_length
          raise RowSizeError.new(row_length, header_length)
        end

        @rows << row
      end
    end

    def scrap_position_if_exist(text)
      if text&.match?(/^\d{1,2}º/i)
        position = text[/^\d{1,2}º/i].strip
        return position.delete 'º'
      end

      text
    end

    def scrap_team_name_if_exist(element)
      title = title_or_nil_helper(element)

      return unless title&.match?(/^[a-záàâãéèêíïóôõöúç\s\-]+ - [a-z]{2}$/i)

      title[/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
    end

    def create_rankings_from_table
      @rows.each do |row|
        ranking = Ranking.new
        ranking.championship = @championship.year
        ranking.serie = @championship.serie

        attrs_rank = Ranking::ATTRS_RANK

        row.cells.each_with_index do |cell, idx|
          ranking.send "#{attrs_rank[idx]}=", cell.value
        end

        @rankings << ranking
      end
    end
  end
end
