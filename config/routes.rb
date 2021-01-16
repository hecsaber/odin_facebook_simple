Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :posts
  resources :users
  resources :friendships, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments
end
