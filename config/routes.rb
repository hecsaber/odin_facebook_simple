Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts
  resources :users
  resources :friendships, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments
end
