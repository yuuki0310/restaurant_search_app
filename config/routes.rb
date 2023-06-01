Rails.application.routes.draw do
  root "restaurants#search"
  resources :restaurants, only: [:index, :show]
end
