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

  root 'home#top'
  get 'home/about'
end