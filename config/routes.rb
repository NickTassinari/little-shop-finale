Rails.application.routes.draw do
  get "/", to: "welcome#index"
  
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get "/admin", to: "admin#index"

  # patch "/merchants/:id/invoice_items/:invoice_item.id", to: "merchants/invoices#show"

  namespace :admin do
    resources :merchants, except: [:destroy], controller: "merchants"
    resources :invoices, only: [:index, :show]
  end

  resources :merchants do
    resources :items, only: [:index, :show, :edit, :update], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
    resources :invoice_items, only: [:update]
  end
end
