Rails.application.routes.draw do
  get 'users/new'

  root 'posts#index'
  resources :posts, only: [:new, :create, :index, :show]

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'
  

end
