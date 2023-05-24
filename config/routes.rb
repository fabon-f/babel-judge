# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#index'

  get 'sign_up', to: 'users#new'
  resources :users, only: %i[show new create destroy]

  get 'sign_in', to: 'user_sessions#new'
  post 'sign_in', to: 'user_sessions#create'
  get 'sign_out', to: 'user_sessions#destroy'

  resource :settings, only: %i[show update]
end
