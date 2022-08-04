Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :paintings, only: %i[index show new create edit update destroy] do
    resources :orders, only: :create
    resources :paiements, only: :new
    collection do
      get 'available'
    end
  end

  resources :pages do
    collection do
      get 'contact'
      get 'artiste'
    end
  end

  resources :users, only: %i[show edit update] do
    resources :orders, only: %i[index show]
  end

  resources :messages, only: :create
end
