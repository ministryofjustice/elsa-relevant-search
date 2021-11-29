require 'rails_helper'

RSpec.describe AnalyticsHelper, type: :helper do
  describe '#analytics_tracking_id' do
    it 'retrieves the environment variable' do
      expect(ENV).to receive(:[]).with('GA_TRACKING_ID')
      helper.analytics_tracking_id
    end
  end

  describe '#analytics_consent_cookie' do
    it 'retrieves the analytics consent cookie' do
      expect(controller.cookies).to receive(:[]).with('elsa_cookies_policy')
      helper.analytics_consent_cookie
    end
  end

  describe '#analytics_allowed?' do
    before do
      allow(ENV).to receive(:[]).with('GA_TRACKING_ID').and_return(tracking_id)
      allow(controller.cookies).to receive(:[]).with('elsa_cookies_policy').and_return(value)
    end

    let(:tracking_id) { nil }
    let(:value) { nil }

    context 'when there is no GA_TRACKING_ID set' do
      it { expect(helper.analytics_allowed?).to eq(false) }
    end

    context 'when there is GA_TRACKING_ID set' do
      let(:tracking_id) { 'xyz123' }

      context 'for an `accept` cookie value' do
        let(:value) { 'accept' }
        it { expect(helper.analytics_allowed?).to eq(true) }
      end

      context 'for a `reject` cookie value' do
        let(:value) { 'reject' }
        it { expect(helper.analytics_allowed?).to eq(false) }
      end
    end
  end
end
