Rails.application.routes.draw do
  root: 'application#home'
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  resources :users do
    member do
      get :confirm_email
    end
  end
end