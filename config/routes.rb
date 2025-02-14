Rails.application.routes.draw do
  # Not Admins
  devise_for :users
  resources :verificacions
  resources :pases_turisticos
  resources :vehiculos
  get 'public/:id', to: 'home#public_show_vehicle', as: :public_show_vehicle

  # Admins
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
        get :download_pdf
        get :preview_pdf
      end
    end
  end

  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end