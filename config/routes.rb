Rails.application.routes.draw do
  root 'posts#index'
  namespace :admin do
    get 'posts/index'
    get 'posts/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/destroy'
  end
  resources :posts
  resources :users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
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
