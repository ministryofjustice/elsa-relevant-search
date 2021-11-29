require 'rails_helper'

RSpec.describe CookiesController do
  describe '#show' do
    it 'renders the expected page' do
      get :show
      expect(response).to render_template(:show)
    end
  end

  describe '#update' do
    before do
      allow(controller).to receive(:cookies).and_return(cookies_double)
      post :update, params: { cookies: value }
    end

    let(:cookies_double) { {} }

    context 'for an `accept` value' do
      let(:value) { 'accept' }

      it 'redirects to the correct place' do
        expect(cookies_double['elsa_cookies_consent']).to eq({ expires: 1.year, value: 'accept' })
        expect(flash[:cookies_consent_updated]).to eq('accept')
        expect(response).to redirect_to('/')
      end
    end

    context 'for a `reject` value' do
      let(:value) { 'reject' }

      it 'redirects to the correct place' do
        expect(cookies_double['elsa_cookies_consent']).to eq({ expires: 1.year, value: 'reject' })
        expect(flash[:cookies_consent_updated]).to eq('reject')
        expect(response).to redirect_to('/')
      end
    end

    context 'for an unknown value' do
      let(:value) { 'foobar' }

      it 'redirects to the correct place' do
        expect(cookies_double['elsa_cookies_consent']).to eq({ expires: 1.year, value: 'reject' })
        expect(flash[:cookies_consent_updated]).to eq('reject')
        expect(response).to redirect_to('/')
      end
    end
  end
end
