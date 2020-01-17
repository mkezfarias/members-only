Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:new, :create, :index, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'
  

end
