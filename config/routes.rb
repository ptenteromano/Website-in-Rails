Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'soon', to: 'pages#soon'
  
  resources :articles
  
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'  // OR see below (one or other)
  resources :users, except: [:new]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # shouldn't be able to delete categories
  resources :categories, except: [:destroy]
  
end
