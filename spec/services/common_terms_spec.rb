require 'rails_helper'

RSpec.describe CommonTerms do
  let(:configuration) { Rails.configuration.x.common_terms }

  describe 'localisation' do
    context 'for locale `en`' do
      let(:locale) { 'en' }

      it 'retrieves the configuration for the locale' do
        expect(configuration).to receive(:fetch).with(locale).and_return([])
        described_class.new(locale: locale)
      end
    end

    context 'for another locale' do
      let(:locale) { 'de' }

      it 'retrieves the configuration for the locale' do
        expect(configuration).to receive(:fetch).with(locale).and_return([])
        described_class.new(locale: locale)
      end
    end
  end

  describe 'quick search groups' do
    subject { described_class.new(locale: 'en') }

    context 'collection' do
      it 'returns a collection of `QuickSearchGroup`' do
        expect(subject).to all(be_an(CommonTerms::QuickSearchGroup))
      end
    end

    # We, on purpose, don't want to test a specific order of the categories,
    # or specific search terms, as that will be changing frequently, so this
    # test only covers the general structure.
    #
    context 'QuickSearchGroup instances' do
      let(:item) { subject.first }

      it 'has categories' do
        expect(subject.size).to be >= 4
      end

      it 'has a category name' do
        expect(item.category).to be_a(String)
      end

      it 'has a search terms array' do
        expect(item.terms).to be_a(Array)
      end

      it 'has enough search terms' do
        expect(item.terms.size).to be >= 4
      end

      it 'renders a partial' do
        expect(item.to_partial_path).to eq('shared/quick_search_group')
      end
    end
  end
end
