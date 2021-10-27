require 'rails_helper'

RSpec.describe AboutController do
  describe '#privacy' do
    it 'renders the expected page' do
      get :privacy
      expect(response).to render_template(:privacy)
    end
  end

  describe '#terms_and_conditions' do
    it 'renders the expected page' do
      get :terms_and_conditions
      expect(response).to render_template(:terms_and_conditions)
    end
  end
end
