Rails.application.routes.draw do
  # get 'restaurants/index'
  # get 'restaurants/show'
  # get 'restaurants/search'
  root "restaurants#search"
  resources :restaurants, only: [:index, :show]
end
