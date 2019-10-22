Rails.application.routes.draw do
  root :to => 'users#index'
  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  post 'product_update' => 'users#update_product'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
