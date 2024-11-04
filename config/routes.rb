Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'authentication#login'
  get '/posts/:id/likes_count', to: 'posts#likes_count'
  # get '/posts/:id/likes_count', to: 'posts#likes_count'
  
  resources :posts, only: [:index, :show, :create, :update, :destroy]

  get '/*a', to: 'application#not_found'
end
