Rails.application.routes.draw do
  # Not Admins
  devise_for :users
  resources :verificacions
  resources :pases_turisticos
  resources :vehiculos

  namespace :admin do
    resources :clubs
    resources :users, only: %i[index show destroy] do
      member do
        patch :reactivate
      end
    end
    
    resources :vehiculos, only: [] do
      member do
        patch :accept
        patch :decline
      end
    end
  end
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
