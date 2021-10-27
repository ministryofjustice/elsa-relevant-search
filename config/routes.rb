Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  get 'about/cookies'
  get 'about/privacy'
  get 'about/terms_and_conditions'

  resource :errors, only: [] do
    get :unhandled
    get :not_found
  end

  # Health and ping endpoints (`status` and `health` are alias)
  defaults format: :json do
    get :status, to: 'health#index'
    get :health, to: 'health#index'
    get :ping,   to: 'health#ping'
  end

  # catch-all route
  match '*path', to: 'errors#not_found', via: :all, constraints:
    lambda { |_request| !Rails.application.config.consider_all_requests_local }
end
