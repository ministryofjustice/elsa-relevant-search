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
      expect(controller.cookies).to receive(:[]).with('elsa_cookies_consent')
      helper.analytics_consent_cookie
    end
  end

  describe '#analytics_consent_accepted?' do
    before do
      allow(controller.cookies).to receive(:[]).with('elsa_cookies_consent').and_return(value)
    end

    context 'cookies has been accepted' do
      let(:value) { CookieSettingsForm::CONSENT_ACCEPT }
      it { expect(helper.analytics_consent_accepted?).to eq(true) }
    end

    context 'cookies has been rejected' do
      let(:value) { CookieSettingsForm::CONSENT_REJECT }
      it { expect(helper.analytics_consent_accepted?).to eq(false) }
    end
  end

  describe '#analytics_allowed?' do
    before do
      allow(ENV).to receive(:[]).with('GA_TRACKING_ID').and_return(tracking_id)
      allow(helper).to receive(:analytics_consent_accepted?).and_return(consent_accepted)
    end

    let(:tracking_id) { nil }
    let(:consent_accepted) { nil }

    context 'when there is no GA_TRACKING_ID set' do
      it { expect(helper.analytics_allowed?).to eq(false) }
    end

    context 'when there is GA_TRACKING_ID set' do
      let(:tracking_id) { 'xyz123' }

      context 'and consent has been granted by the user' do
        let(:consent_accepted) { true }
        it { expect(helper.analytics_allowed?).to eq(true) }
      end

      context 'and consent has not been granted by the user' do
        let(:consent_accepted) { false }
        it { expect(helper.analytics_allowed?).to eq(false) }
      end
    end
  end
end
