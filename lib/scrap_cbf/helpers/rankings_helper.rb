# frozen_string_literal: true

require_relative 'lib/element_nokogiri'
require_relative 'lib/findable'

class ScrapCbf
  module RankingsHelper
    include ElementNokogiri
    include Findable

    def title_or_nil_helper(element)
      child_elem = element.children.find do |elem|
        elem.element? && elem.key?('title')
      end

      child_elem['title'] if child_elem
    end
  end
end
