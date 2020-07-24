Rails.application.routes.draw do
  
  resources :categories 
  get '/' => 'sessions#home' 
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  get '/most_popular' => 'restaurants#most_popular' 

  get '/auth/:provider/callback' => 'sessions#create'
 
  
  resources :reviews
  resources :restaurants do
    resources :reviews, only: [:new, :index]
  end

  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
