Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # OnniAuth routes
  get "/auth/:provider/callback" => "sessions/omni_auths#create", as: :omniauth_callback
  get "/auth/failure" => "sessions/omni_auths#failure", as: :omniauth_failure

  root to: "landing_page#landing"

  # Dashboards
  namespace :business do
    get "/dashboard", to: "dashboard#index", as: :dashboard
  end

  namespace :volunteer do
    get "/dashboard", to: "dashboard#index", as: :dashboard
  end

  namespace :organization do
    get "/dashboard", to: "dashboard#index", as: :dashboard
  end

  # Missions
  resources :missions do
    post :deactivate, on: :member
  end
end
