Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resource :errors, only: [] do
    get :unhandled
    get :not_found
  end

  # catch-all route
  match '*path', to: 'errors#not_found', via: :all, constraints:
    lambda { |_request| !Rails.application.config.consider_all_requests_local }
end
