require "sidekiq/web"
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  mount Sidekiq::Web => '/sidekiq'

  root to: "pages#index"
  namespace :admin do
    resources :orders, only: [:index, :show, :destroy]
  end
  resources :products
  resources :orders, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
