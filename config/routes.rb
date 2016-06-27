Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'users' => 'users#index'
      get 'users/me' => 'users#me'
      post 'users/create' => 'users#create'
      
    end
  end
end
