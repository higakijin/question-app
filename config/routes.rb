Rails.application.routes.draw do
  root 'posts#index'
  namespace :admin do
    get 'posts' => 'posts#index', as: 'posts'
    delete 'posts/:id' => 'posts#destroy', as: 'post'
  end
  namespace :admin do
    get 'users'=> 'users#index', as: 'users'
    delete 'users/:id' => 'users#destroy', as: 'user'
  end
  resources :posts, except: [:index] do
    resources :answers, only: [:create, :destroy], as: 'comments'
  end
  resources :users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/posts/:id' => 'posts#solved_button', as: 'solved_button'
  
  get '/unsolved' => 'posts#unsolved'
  get '/solved' => 'posts#solved'
  # get 'answers/create'
  # get 'posts/index'
  # get 'posts/new'
  # get 'posts/create'
  # get 'posts/show'
  # get 'posts/edit'
  # get 'posts/destroy'
  # get 'posts/index'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'users/new'
  # get 'users/create'
  # get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
