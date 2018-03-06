Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  post 'create', to: 'users#create'

  # Login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Home
  root 'home#index'
end
