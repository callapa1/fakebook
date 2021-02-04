Rails.application.routes.draw do
  root "users#index"
  devise_for :users, :controllers => { registrations: "registrations"}

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/signup' => 'devise/registrations#new'
  end

  resources :posts
  get "/friends", to: "invitations#index"
  resources :invitations, only: [:create, :update, :destroy]
end