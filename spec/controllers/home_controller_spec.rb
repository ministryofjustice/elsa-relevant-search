require 'rails_helper'

RSpec.describe HomeController do
  describe '#index' do
    it 'renders the expected page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  # Note: the following tests use generic concerns, happening in all controllers,
  # but we just need to test it once, no need to test in every controller.
  #
  describe 'Security handling' do
    context '#drop_dangerous_headers!' do
      it 'removes dangerous headers' do
        request.headers.merge!('HTTP_X_FORWARDED_HOST' => 'foobar.com')
        get :index
        expect(request.env).not_to include('HTTP_X_FORWARDED_HOST')
      end
    end

    context 'basic HTTP auth' do
      it 'checks for the ENV variable' do
        expect(ENV).to receive(:fetch).with('HTTP_AUTH_ENABLED', false)
        get :index
      end
    end
  end
end
