Rails.application.routes.draw do
  devise_for :users
  root to: "restaurants#index"
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
