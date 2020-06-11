Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end
  root to: "items#index"
  resources :items do
    resources :favorites, only: [:index, :create, :destroy]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'search'
      get 'detail_search'
    end
    member do
      get 'purchaseConfilmation'
      post 'pay'
      get 'purchaseCompleted'
    end
  end

  resources :users, only: [:show] do
    collection do
      get 'users/mypage', to: "users#mypage"
      get 'users/logout', to: "users#logout"
      get 'users/buy', to: "users#buy"
    end
  end

  resources :cards, only: %i[new create destroy show]
  resources :categories
end
