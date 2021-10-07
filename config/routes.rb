Rails.application.routes.draw do
  root 'posts#index'
  get '/admin' => 'admin/users#new'
  post '/admin' => 'admin/users#create'
  namespace :admin do
    get 'posts' => 'posts#index', as: 'posts'
    get 'posts/search' => 'posts#search'
    delete 'posts/:id' => 'posts#destroy', as: 'post'

    get 'users'=> 'users#index', as: 'users'
    get 'users/search' => 'users#search'
    delete 'users/:id' => 'users#destroy', as: 'user'

    get 'comments' => 'comments#index', as: 'comments'
    get 'comments/search' => 'comments#search'
    delete 'comments/:id' => 'comments#destroy', as: 'comment'
  end
  resources :posts, except: [:index] 
  post '/posts/:post_id' => 'answers#create', as: 'post_comments'
  get 'search' => 'posts#search'
  resources :users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/posts/:id/solved' => 'posts#solved_button', as: 'solved_button'
  
  get '/unsolved' => 'posts#unsolved'
  get '/unsolved/search' => 'posts#search_unsolved'
  get '/solved' => 'posts#solved'
  get '/solved/search' => 'posts#search_solved'

end
