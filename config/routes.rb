Rails.application.routes.draw do
  resources :cars do
    collection do
      get 'book'
      get 'checkout'
    end
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'book_car', to: 'car#book'
  get 'checkout_car', to: 'car#checkout'
  get 'suggestion_dashboard', to: 'dashboard#suggestion'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'dashboard' => 'dashboard#index'
  get 'home' => 'home#index'
  get 'sign_up' => 'home#sign_up'
  get 'login' => 'home#login'

  post 'sign_up', to:'home#user_sign_up'
  post 'login', to:'home#user_login'
end
