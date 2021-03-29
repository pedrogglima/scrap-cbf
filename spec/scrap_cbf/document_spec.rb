# frozen_string_literal: true

require 'json'

RSpec.describe ScrapCbf::Document do
  let(:klass) { ScrapCbf::Document }

  let(:url) { 'https://www.cbf.com.br/futebol-brasileiro/competicoes' }
  let(:championship_year) { (2012..Date.today.year.to_i).to_a }
  let(:divisions) { %i[serie_a serie_b] }
  let(:divisions_paths) do
    {
      serie_a: 'campeonato-brasileiro-serie-a',
      serie_b: 'campeonato-brasileiro-serie-b'
    }
  end

  describe 'costants' do
    it { expect(klass::URL).to eq(url) }
    it { expect(klass::CHAMPIONSHIP_YEARS).to eq(championship_year) }
    it { expect(klass::DIVISIONS).to eq(divisions) }
    it { expect(klass::DIVISIONS_PATH).to eq(divisions_paths) }

    pending 'sample_path mock FILE PATH'
  end

  describe 'class methods' do
    subject { klass.parse_document(2020, :serie_a, { load_from_sample: true }) }
    it do
      expect(subject.class).to(be(Nokogiri::HTML::Document))
    end
  end

  describe 'initialize' do
    subject { klass.new(2020, :serie_a, { load_from_sample: true }) }

    it { expect(subject.year).to(eq(2020)) }
    it { expect(subject.division).to(eq(:serie_a)) }
    it { expect(subject.load_from_sample).to(eq(true)) }
    it { expect(subject.sample_path).to(eq(nil)) }
    it do
      expect(subject.parsed_document.class).to(
        be(Nokogiri::HTML::Document)
      )
    end
  end
end
