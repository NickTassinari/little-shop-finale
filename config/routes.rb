Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update], controller: "merchants"
    resources :invoices, only: [:index, :show]
  end

  resources :merchants do
    resources :items, only: [:index, :show], controller: "merchants/items"
    resources :invoices, only: [:index], controller: "merchants/invoices"
  end
end
