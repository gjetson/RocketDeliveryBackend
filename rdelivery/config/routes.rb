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
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "home#index" 
  
  # Defines the root path route ("/")
  # root "articles#index"
end
