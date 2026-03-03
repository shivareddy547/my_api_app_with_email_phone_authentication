# Backend file for user 1, project my_api_app_with_email_phone_authentication
# Path: config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :contacts, only: [:create]

    post 'auth/signup', to: 'auth#signup'
    post 'auth/login', to: 'auth#login'
    post 'auth/otp_login', to: 'auth#otp_login'
    post 'auth/verify_otp', to: 'auth#verify_otp'
    post 'auth/refresh', to: 'auth#refresh'
    delete 'auth/logout', to: 'auth#logout'
    get 'auth/me', to: 'auth#me'

    post 'auth/password/forgot', to: 'auth#forgot_password'
    post 'auth/password/reset', to: 'auth#reset_password'

    resources :menu_items, only: [:index, :create, :update, :destroy] do
      patch :availability, on: :member
    end

    resources :categories, only: [:index, :create, :destroy]

    resources :orders, only: [:create, :show, :index, :update] do
      patch :status, on: :member
    end

    post 'payments/process', to: 'payments#process_payment'

    resources :floors, only: [:index, :create, :show, :update, :destroy] do
      resources :tables, only: [:index, :create, :show, :update, :destroy] do
        post :start_order, on: :member
        patch :clear, on: :member
      end
    end

    resources :staff, controller: 'staff_members', only: [:index, :create, :show, :update, :destroy] do
      patch :status, on: :member
    end

    # Reports API endpoints
    get 'reports', to: 'reports#index'
    get 'reports/stats', to: 'reports#stats'
    get 'reports/top-items', to: 'reports#top_items'
    get 'reports/recent-orders', to: 'reports#recent_orders'
    get 'reports/hourly-sales', to: 'reports#hourly_sales'
  end

  if defined?(Rswag::Ui::Engine)
    mount Rswag::Ui::Engine => "/api-docs"
    mount Rswag::Api::Engine => "/api-docs"
  end
end
