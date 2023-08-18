Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :tasks do
      member do
        put 'status'
      end
    end
  end
end
