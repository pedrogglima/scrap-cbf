# frozen_string_literal: true

class ScrapCbf
  # This class is responsible for:
  # - Handler users input.
  # - Fetch html page from CBF official page.
  # - Parse html page with Nokogiri.
  class Document
    URL = 'https://www.cbf.com.br/futebol-brasileiro/competicoes'

    CHAMPIONSHIP_YEARS = (2012..Date.today.year.to_i).to_a.freeze

    SERIES = %i[serie_a serie_b].freeze

    SERIES_PATH = {
      serie_a: 'campeonato-brasileiro-serie-a',
      serie_b: 'campeonato-brasileiro-serie-b'
    }.freeze

    SAMPLE_PATH = "#{File.dirname(__FILE__)}/samples/" \
    'cbf_serie_a_2020.html'

    class << self
      def parse_document(year, serie, opts)
        new(year, serie, opts).parsed_document
      end
    end

    attr_reader :year,
                :serie,
                :load_from_sample,
                :sample_path,
                :parsed_document

    # @param [Integer] year the Championship year
    # @param [Symbol] serie the Championship serie. see SERIES.
    # @option opts [Boolean] load_from_sample yes or no to load specific
    #  HTML file
    # @option opts [Symbol] sample_path path to the sample otherwise default
    #
    # @return [Document] new instance
    def initialize(year, serie, opts)
      @year = year
      @serie = serie
      @load_from_sample = opts.fetch(:load_from_sample) { false }
      @sample_path = opts[:sample_path]

      @parsed_document =
        parse_document(year, serie, @load_from_sample, @sample_path)
    end

    private

    # @param [Integer] year the Championship year
    # @param [Symbol] serie the Championship serie. see SERIES.
    # @option opts [Boolean] load_from_sample yes or no to load specific
    #  HTML file
    # @option opts [Symbol] sample_path path to the sample otherwise default
    #
    # @return [Nokogiri::HTML::Document] new instance
    def parse_document(year, serie, load_from_sample, sample_path)
      url = if load_from_sample
              sample_path || SAMPLE_PATH
            else
              raise_year_error if year_out_of_range?(year)
              raise_serie_error if serie_out_of_range?(serie)

              build_url(year, serie)
            end
      Nokogiri::HTML(URI.open(url))
    end

    def build_url(year, serie)
      "#{URL}/#{SERIES_PATH[serie]}/#{year}"
    end

    def year_out_of_range?(year)
      !CHAMPIONSHIP_YEARS.include?(year)
    end

    def serie_out_of_range?(serie)
      !SERIES.include?(serie)
    end

    def raise_year_error
      raise OutOfRangeArgumentError.new(:year, CHAMPIONSHIP_YEARS)
    end

    def raise_serie_error
      raise OutOfRangeArgumentError.new(:serie, SERIES)
    end
  end
end
