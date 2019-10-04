Rails.application.routes.draw do
  root 'home#new'
  # post 'users#confirm_singup'
  # post 'users/confirmationtoken/confirm_mail', :to => 'users#confirm_signup'
  post 'users/confirm_signup', :to => 'users#confirm_signup'  
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  resources :users do
    member do
      get :confirm_email
    end
  end
end
