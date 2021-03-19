# frozen_string_literal: true

class ScrapCbf
  class HeaderColumn
    attr_reader :value, :title
    def initialize(value, title)
      @value = value
      @title = title || nil
    end
  end
end
