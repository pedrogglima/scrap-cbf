# frozen_string_literal: true

require_relative 'lib/element_nokogiri'
require_relative 'lib/findable'

class ScrapCbf
  module TeamsHelper
    include ElementNokogiri
    include Findable
  end
end
