Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]

  # resources :books do
  # resources :favorites,only: [:create,:destroy]
  # end

  resources :books
  resources :favorites,only: [:destroy]
  post '/favorites/:id', to: 'favorites#create'

  resources :book_comments,only: [:destroy]
  post '/book_comments/:id', to: 'book_comments#create'

  resources :relationships, only: [:create, :destroy]
  get '/followings/:id', to: 'relationships#followings_show',as: :following
  get '/follower/:id', to: 'relationships#followers_show',as: :follower
  
  get '/search', to: 'search#search'

  root 'home#top'
  get 'home/about'
end