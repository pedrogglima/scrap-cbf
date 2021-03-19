# frozen_string_literal: true

class ScrapCbf
  # This helper is a outliner. The purpose of this module is given a
  # better interface for the object generate by Nokogiri.
  # We can think as them as an extansion for the Nokogiri obj element.
  # This module may disappear later.
  module ElementNokogiri
    def element_hidden?(element)
      element['style']&.eql?('display: none')
    end

    def remove_whitespace(element)
      element.text.gsub(/\s+/, '')
    end
  end
end
