Rails.application.routes.draw do
  resources :cars do
    collection do
      get 'book'
      get 'checkout'
      get 'return'
      get 'register_for_email'
    end
  end
  resources :users do
    collection do
      get 'new_superadmin'
      get 'view_superadmin'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  get 'book_car', to: 'car#book'
  get 'checkout_car', to: 'car#checkout'
  get 'suggest_car', to: 'dashboard#suggest_car'

  post 'suggest_car', to: 'dashboard#new_suggest_car'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'dashboard' => 'dashboard#index'
  get 'home' => 'home#index'
  get 'sign_up' => 'home#sign_up'
  get 'login' => 'home#login'

  get 'logins' => 'home#login'

  post 'sign_up', to:'home#user_sign_up'
  post 'logins', to:'home#user_login'

  get 'logout' => 'dashboard#logout'
end
