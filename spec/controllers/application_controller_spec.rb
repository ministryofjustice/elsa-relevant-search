require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def my_url; true; end
    def an_exception; raise Exception; end
  end

  before do
    allow(Rails.application).to receive_message_chain(:config, :consider_all_requests_local).and_return(false)
  end

  context 'Security handling' do
    before do
      routes.draw { get 'my_url' => 'anonymous#my_url' }
    end

    context '#drop_dangerous_headers!' do
      it 'removes dangerous headers' do
        request.headers.merge!('HTTP_X_FORWARDED_HOST' => 'foobar.com')
        get :my_url
        expect(request.env).not_to include('HTTP_X_FORWARDED_HOST')
      end
    end

    context 'basic HTTP auth' do
      it 'checks for the ENV variable' do
        expect(ENV).to receive(:fetch).with('HTTP_AUTH_ENABLED', false)
        get :my_url
      end
    end
  end

  context 'Exceptions handling' do
    context 'General catch-all exception' do
      it 'should report the exception, and redirect to the error page' do
        routes.draw { get 'an_exception' => 'anonymous#an_exception' }

        expect(Raven).to receive(:capture_exception)

        get :an_exception
        expect(response).to redirect_to(unhandled_errors_path)
      end
    end
  end
end
