Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"
  resources :restaurants, only: [:index, :new, :create]
  resources :tags, only: [:show]
end
