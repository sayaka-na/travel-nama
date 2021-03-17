Rails.application.routes.draw do

  root to: 'homes#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :likes
    end
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end

end
