Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :companies, only: [:new, :edit, :create, :update]
  resources :positions
  resources :applicants, only: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
