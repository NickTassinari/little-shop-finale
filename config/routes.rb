Rails.application.routes.draw do
  get "/", to: "welcome#index"
  
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update], controller: "merchants"
    resources :invoices, only: [:index, :show]
  end

  resources :merchants do
    resources :items, only: [:index, :show], controller: "merchants/items"
  end
end
