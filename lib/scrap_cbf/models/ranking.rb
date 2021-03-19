# frozen_string_literal: true

class ScrapCbf
  class Ranking
    # @todo Translate attrs_acessors to English
    ATTR_ACCESSORS = %i[
      posicao
      team
      pontos
      jogos
      vitorias
      empates
      derrotas
      gols_pro
      gols_contra
      saldo_de_gols
      cartoes_amarelos
      cartoes_vermelhos
      aproveitamento
      recentes
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
