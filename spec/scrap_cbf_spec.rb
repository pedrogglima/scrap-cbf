# frozen_string_literal: true

require 'json'

RSpec.describe ScrapCbf do
  let(:klass) { ScrapCbf }
  let(:new_instance) { klass.new }

  it 'has a version number' do
    expect(ScrapCbf::VERSION).not_to be nil
  end

  subject { new_instance }

  describe 'initialize' do
    it { expect(subject.championship).to be_a(klass::Championship) }
    it { expect(subject.document).to be_a(klass::Document) }
    it { expect(subject.matches).to be_a(klass::MatchesBuilder) }
    it { expect(subject.rankings).to be_a(klass::RankingsBuilder) }
    it { expect(subject.rounds).to be_a(klass::RoundsBuilder) }
    it { expect(subject.teams).to be_a(klass::TeamsBuilder) }
  end

  describe 'to_h' do
    subject { new_instance.to_h }

    it { expect(subject).to be_a(Hash) }

    context 'to has indifferent access' do
      subject { new_instance.to_h[:championship] }

      it { expect(subject[:year]).to be_a(Integer) }
      it { expect(subject['year']).to be_a(Integer) }
    end

    context 'to has keys' do
      it { expect(subject.key?(:championship)).to be(true) }
      it { expect(subject.key?(:matches)).to be(true) }
      it { expect(subject.key?(:rankings)).to be(true) }
      it { expect(subject.key?(:rounds)).to be(true) }
      it { expect(subject.key?(:teams)).to be(true) }
    end
  end

  describe 'to_json' do
    subject { new_instance.to_json }

    it { expect(subject).to be_a(String) }

    context 'be a valid json' do
      it { expect { JSON.parse(subject) }.to_not raise_error }
    end

    context 'to not be empty' do
      it { expect(!subject.empty?).to be(true) }
    end
  end

  pending 'print method'
end
