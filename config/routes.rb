Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users

  namespace :api do
    namespace :v1 do
      # sessions
      post 'sessions' => 'sessions#create'

      # users
      get 'users' => 'users#index'
      post 'users' => 'users#create'
      get 'users/find' => 'users#find'
      get 'users/:id' => 'users#show'

      # tasks
      get 'tasks' => 'tasks#index'
      post 'tasks' => 'tasks#create'
      get 'tasks/:id' => 'tasks#show'
      put 'tasks/:id' => 'tasks#update'
      delete 'tasks/:id' => 'tasks#delete'

      # assignments
      get 'assignments' => 'assignments#index'
      post 'assignments' => 'assignments#create'
      get 'assignments/:id' => 'assignments#show'
      delete 'assignments/:id' => 'assignments#delete'
    end
  end
end
