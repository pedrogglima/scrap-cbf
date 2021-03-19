# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class ScrapCbf
  # This class is responsible for:
  # - Handler users input.
  # - Fetch html page from CBF official page.
  # - Parse html page with Nokogiri.
  class Document
    URL = 'https://www.cbf.com.br/futebol-brasileiro/competicoes'

    CHAMPIONSHIP_YEARS = (2012..Date.today.year.to_i).to_a.freeze

    DIVISIONS = %i[serie_a serie_b].freeze

    DIVISIONS_PATH = {
      serie_a: 'campeonato-brasileiro-serie-a',
      serie_b: 'campeonato-brasileiro-serie-b'
    }.freeze

    SAMPLE_PATH = "#{File.dirname(__FILE__)}/samples/" \
    'cbf_division_a_2020.html'

    attr_reader :year,
                :division,
                :load_from_sample,
                :sample_path,
                :parsed_document

    # @param [Integer] year the Championship year
    # @param [Symbol] division the Championship division. see DIVISIONS.
    # @option opts [Boolean] load_from_sample yes or no to load specific
    #  HTML file
    # @option opts [Symbol] sample_path path to the sample otherwise default
    #
    # @return [Document] new instance
    def initialize(year, division, opts)
      load_from_sample = opts.fetch(:load_from_sample) { false }
      sample_path = opts[:sample_path]

      @parsed_document =
        parse_document(year, division, load_from_sample, sample_path)
    end

    def parse_document(year, division, load_from_sample, sample_path)
      url = if load_from_sample
              sample_path || SAMPLE_PATH
            else
              raise_year_error if year_out_of_range?(year)
              raise_division_error if division_out_of_range?(division)

              build_url(year, division)
            end
      Nokogiri::HTML(URI.open(url))
    end

    private

    def build_url(year, division)
      "#{URL}/#{DIVISIONS_PATH[division]}/#{year}"
    end

    def year_out_of_range?(year)
      !CHAMPIONSHIP_YEARS.include?(year)
    end

    def division_out_of_range?(division)
      !DIVISIONS.include?(division)
    end

    def raise_year_error
      raise OutOfRangeArgumentError.new(:year, CHAMPIONSHIP_YEARS)
    end

    def raise_division_error
      raise OutOfRangeArgumentError.new(:division, DIVISIONS)
    end
  end
end
