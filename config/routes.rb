Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"

  get '/restaurants/searchcategory',  to: 'restaurants#search_category'

  resources :restaurants do
    collection do
      get 'search'
    end
    resources :gos, only: [:create]
    resources :wents, only: [:create]
  end
  resources :tags, only: [:show, :destroy] do
    member do
      get 'search'
    end
  end
end
