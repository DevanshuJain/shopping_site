Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  get 'products/index'
  root 'products#index'
  # resources :products

  resources :products 
  resources :carts 
  resources :charges
  post 'carts/callback'

  authenticated do
    root to: "products#index", as: :authenticated_root
  end

  get 'products/:id/add_to_cart' => 'carts#add_to_cart', :as => 'add_to_cart'
  get 'carts/:id/remove' => 'carts#remove', :as => 'remove'
  
  get 'seller_product' => 'products#seller_product', :as => 'seller_product'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
