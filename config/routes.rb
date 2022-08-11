Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resources :paintings, only: %i[index show new create edit update destroy] do
    resources :orders, only: %i[new create] do
      member do
        get 'paiement'
      end
    end
    collection do
      get 'available'
    end
  end

  resources :pages do
    collection do
      get 'contact'
      get 'artiste'
      get 'success'
    end
  end

  resources :users, only: %i[show edit update] do
    resources :orders, only: %i[index show]
  end

  resources :messages, only: :create

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
