Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end
  root "splash#index"
  
  resources :users
  resources :categories do
    resources :expenses
  end
end
