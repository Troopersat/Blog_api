Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'authentication#login'
  
  resources :posts, only: [:index, :show, :create, :update, :destroy] do
    member do
      post 'like', to: 'posts#like'           # Points to PostsController
      get 'likes_count', to: 'posts#likes_count' # Points to PostsController
    end
  end

  get '/*a', to: 'application#not_found'
end
