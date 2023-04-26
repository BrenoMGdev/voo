Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :pilots 
  resources :planes, param: :registration
  resources :models
  resources :airports, param: :icao
  resources :flights, param: :flight_number
  resources :flight_schedules, :path => "flightSchedules"
end
