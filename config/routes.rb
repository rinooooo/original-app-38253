Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"

  get '/restaurants/searchcategory',  to: 'restaurants#search_category'

  resources :restaurants, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
  resources :tags, only: [:show] do
    member do
      get 'search'
    end
  end
end
