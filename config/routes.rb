Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do

    post 'sign_in', to: 'user_auth#create'
    delete 'destroy', to: 'user_auth#destroy_account'
    post 'sign_up', to: 'user_auth#create_account'


    patch 'users/profile', to: 'users#update'
    resources :recipes, only: [:index, :create]
  end
  root 'welcome#index'
end
