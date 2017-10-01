Rails.application.routes.draw do
  resources :cars do
    collection do
      get 'book_car'
      get 'checkout'
      get 'return_car'
      get 'register_for_email'
      get 'cancel_booking'
    end
  end
  resources :users do
    collection do
      get 'new_superadmin'
      get 'view_superadmin'
      get 'view_user'
      get 'edit_user'
      get 'delete_user'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  get 'suggest_car', to: 'dashboard#suggest_car'

  post 'suggest_car', to: 'dashboard#new_suggest_car'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'dashboard' => 'dashboard#index'
  get 'edit_profile' => 'dashboard#edit_profile'
  get 'home' => 'home#index'
  get 'sign_up' => 'home#sign_up'
  get 'login' => 'home#login'
  get 'check_out' => 'templates#car_checkout'

  get 'make_reservation' =>'dashboard#make_reservation'
  get 'cancel_reservation' =>'cars#cancel_reservation'


  get 'logins' => 'home#login'
  get 'sign_ups' => 'home#sign_up'
  get 'car_checkouts' => 'cars#checkout'
  get 'user_edits' => 'dashboard#edit_profile'

  post 'sign_ups', to:'home#user_sign_up'
  post 'logins', to:'home#user_login'
  post 'make_reservation', to:'dashboard#user_make_reservation'
  post 'car_checkouts' => 'cars#do_checkout'
  post 'user_edits' => 'dashboard#do_edit_profile'

  get 'logout' => 'dashboard#logout'
end