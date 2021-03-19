# frozen_string_literal: true

require 'json'
require 'active_support/core_ext/hash/indifferent_access'
require 'forwardable'

require_relative 'scrap_cbf/errors'
require_relative 'scrap_cbf/formattable'
require_relative 'scrap_cbf/printable'
require_relative 'scrap_cbf/document'
require_relative 'scrap_cbf/models/table/header_column'
require_relative 'scrap_cbf/models/table/row'
require_relative 'scrap_cbf/models/table/cell'
require_relative 'scrap_cbf/models/championship'
require_relative 'scrap_cbf/models/team'
require_relative 'scrap_cbf/models/round'
require_relative 'scrap_cbf/models/match'
require_relative 'scrap_cbf/models/ranking'
require_relative 'scrap_cbf/helpers/matches_helper'
require_relative 'scrap_cbf/helpers/rankings_helper'
require_relative 'scrap_cbf/helpers/teams_helper'
require_relative 'scrap_cbf/builders/matches_builder'
require_relative 'scrap_cbf/builders/matches_per_round_builder'
require_relative 'scrap_cbf/builders/rankings_builder'
require_relative 'scrap_cbf/builders/rounds_builder'
require_relative 'scrap_cbf/builders/teams_builder'

# ScrapCbf is a gem created for scraping data from the CBF official page.
# Some of the data found on the CBF page are:
# teams, matches, rounds and ranking table from all championships founded
# on the official page.
class ScrapCbf
  include Formattable
  include Printable

  # @!attribute [r] document
  #   @return [ScrapCbf::Document] ScrapCbf::Document instance.
  # @!attribute [r] championship
  #   @return [ScrapCbf::Championship] ScrapCbf::Championship instance.
  attr_reader :document
  attr_reader :championship

  # @param [Hash] opts
  # @option opts [Integer] :year The Championship year.
  # @option opts [Symbol] :division The Championship division.
  # @option opts [Symbol] :load_from_sample Load championship from sample.
  # @option opts [Symbol] :sample_path to the sample otherwise default
  #
  # @return [ScrapCbf] new instance
  def initialize(opts = {})
    year = opts.fetch(:year, Date.today.year.to_i)
    division = opts.fetch(:division, :serie_a)

    @document = Document.new(year, division, opts)
    @parsed_document = @document.parsed_document
    @championship = Championship.new(year, division)
  end

  # returns all entities scraped in hash format.
  def to_h
    {
      championship: championship.to_h,
      matches: matches.to_h,
      rankings: rankings.to_h,
      rounds: rounds.to_h,
      teams: teams.to_h

    }.with_indifferent_access
  end

  # @return [TeamsBuilder] instance.
  def teams
    @teams ||= TeamsBuilder.new(@parsed_document)
  end

  # @return [RoundsBuilder] instance.
  def rounds
    @rounds ||= RoundsBuilder.new(@parsed_document)
  end

  # @return [MatchesBuilder] instance.
  def matches
    @matches ||= rounds.matches_builder
  end

  # @return [RankingsBuilder] instance.
  def rankings
    @rankings ||= RankingsBuilder.new(@parsed_document)
  end
end
