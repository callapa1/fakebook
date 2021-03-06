Rails.application.routes.draw do
  root "posts#index"

  # Devise
  devise_for :users, :controllers => { registrations: "registrations", confirmations: "confirmations"}
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/signup' => 'devise/registrations#new'
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :invitations, only: [:create, :update, :destroy]
  resources :post_likes, only: [:create, :destroy]
  resources :users, only: [:show]
  get '/user/:id', to: 'users#show'

  get "/friends", to: "invitations#index"
end