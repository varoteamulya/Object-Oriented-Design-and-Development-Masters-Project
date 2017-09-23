Rails.application.routes.draw do
  resources :cars
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'book_car', to: 'cars#book'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
