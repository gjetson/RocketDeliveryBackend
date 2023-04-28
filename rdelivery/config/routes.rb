Rails.application.routes.draw do
  resources :couriers
  resources :courier_statuses

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :customers
  resources :restaurants
  resources :addresses
  resources :employees
  resources :order_statuses
  resources :product_orders
  resources :orders
  resources :products

  namespace :api do
    get "products", to: "products#index"
    get "restaurants", to: "restaurants#index"
    get "orders", to: "orders#index"
    post "order", to: "orders#create"
    post "login", to: "auth#index"
    post "order/:id/status", to: "orders#status"
    get "account/:id", to: "auth#getAccount"
    post "account/:id", to: "auth#updateAccount"
  end
  
  root to: 'home#index'
end
