Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#homepage'

  get 'about', to: 'pages#about'

  resources :articles

  #post 'users', to: 'users#create'
  resources :users, except: [:new]

  get 'signup', to: 'users#new'
end
