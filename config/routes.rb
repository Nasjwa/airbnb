Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/new'
  get 'bookings/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :flats, only: [:index, :show] do
    # Nested bookings routes (for booking a flat)
    resources :bookings, only: [:new, :create]
  end

  # My bookings page
  resources :bookings, only: [:index]
end
