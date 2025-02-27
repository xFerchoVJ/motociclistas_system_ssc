Rails.application.routes.draw do
  # Not Admins
  devise_for :users
  resources :verificacions
  resources :pases_turisticos
  resources :vehiculos
  resources :appointments do
    collection do
      get 'available_times', to: "appointments#available_times"
    end
    member do
      patch 'cancelate_appointment', to: "appointments#cancelate_appointment"
    end
  end
  get 'public/:id', to: 'home#public_show_vehicle', as: :public_show_vehicle
  get 'info-user/:id', to: 'home#info_user', as: :info_user

  # Admins
  namespace :admin do
    resources :clubs
    resources :appointments do
      member do
        patch :confirm_appointment
      end
    end
    resources :users, only: %i[index show destroy] do
      member do
        patch :reactivate
        patch :approve_user
        get :generate_pdf
        get :view_pdf
        get :download_pdf
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