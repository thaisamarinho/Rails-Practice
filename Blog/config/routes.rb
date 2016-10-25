Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "home#index", as: :home

  get "/about" => "home#about"

  resources :users, only: [:new, :create, :edit, :update]
  resources :passwords, only: [:edit, :update] 
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts do
    resources :comments
  end


end
