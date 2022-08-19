Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: "restaurants#index"
  get '/restaurants/searchcategory',  to: 'restaurants#search_category'
  get '/relationships/searchcategory',  to: 'relationships#search_category'

  resources :restaurants do
    collection do
      get 'search'
    end
    resources :gos, only: [:create]
    resources :wents, only: [:create]
    resources :comments, only: [:create, :destroy]
  end

  resources :tags, only: [:show, :destroy] do
    member do
      get 'search'
    end
    get '/tags/searchcategory',  to: 'tags#search_category'
  end

  resources :users do
    resource :relationships, only: [:create, :destroy, :new, :show] do
      collection do
        get 'search'
      end
    end
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

end
