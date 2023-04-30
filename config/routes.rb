Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks 
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    root 'admin/users#index'
    resources :users
  end
end
