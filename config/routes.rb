Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :tasks do
      collection do
        get 'public'
        get 'private'
      end
    end
  end
end
