# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#index'

  get 'sign_up', to: 'users#new'
  resources :users, except: %i[index new]
end
