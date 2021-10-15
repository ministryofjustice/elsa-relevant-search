require 'rails_helper'

RSpec.describe HealthController, type: :controller do
  # This is very-happy-path to ensure the controller responds. The bulk of the
  # status is tested in spec/services/status_spec.rb.
  describe '#index' do
    let(:status) { instance_double(Status, result: result, success?: success) }

    let(:result) {
      {
        service_status: 'ok',
        dependencies: {
          database_status: 'ok',
        }
      }.to_json
    }

    before do
      allow(Status).to receive(:new).and_return(status)
    end

    context 'for a healthy service' do
      let(:success) { true }

      it 'has a 200 response code' do
        get :index, format: :json
        expect(response.status).to eq(200)
      end

      it 'returns json' do
        get :index, format: :json
        expect(response.body).to eq(result)
      end
    end

    context 'for a non healthy service' do
      let(:success) { false }

      it 'has a 503 response code' do
        get :index, format: :json
        expect(response.status).to eq(503)
      end

      it 'returns json' do
        get :index, format: :json
        expect(response.body).to eq(result)
      end
    end
  end

  describe '#ping' do
    it 'has a 200 response code' do
      get :ping, format: :json
      expect(response.status).to eq(200)
    end

    it 'returns the expected payload' do
      get :ping, format: :json
      expect(
        JSON.parse(response.body).keys
      ).to eq(%w(build_date build_tag commit_id))
    end
  end
end
