# Backend file for user 1, project my_api_app
# Path: config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :contacts, only: [:index, :create]

     post 'auth/signup', to: 'auth#signup'
    post 'auth/login', to: 'auth#login'
    post 'auth/otp_login', to: 'auth#otp_login'
    post 'auth/verify_otp', to: 'auth#verify_otp'
    post 'auth/refresh', to: 'auth#refresh'
    delete 'auth/logout', to: 'auth#logout'
    get 'auth/me', to: 'auth#me'

    # Password reset
    post 'auth/password/forgot', to: 'auth#forgot_password'
    post 'auth/password/reset', to: 'auth#reset_password'
  end

  # Defines the root path route ("/")
  # root "posts#index"
# Mount RSwag for API documentation (only if RSwag is available)
if defined?(Rswag::Ui::Engine)
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
end
end
