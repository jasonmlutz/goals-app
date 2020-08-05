Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:new, :create, :show, :update, :destroy]
end
