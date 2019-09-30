Rails.application.routes.draw do
  resources :users, param: :_username
  resources: :tasks
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  resources :users do
    member do
      get :confirm_email
    end
  end
end