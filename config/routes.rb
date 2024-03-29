Rails.application.routes.draw do
  get 'sitemaps/index'
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
      get 'ondemand'
      get 'artiste'
      get 'success'
    end
  end

  resources :users, only: %i[show edit update] do
    resources :orders, only: %i[index show]
  end

  resources :orders, only: :admin do
    collection do
      get 'admin'
    end
    member do
      get 'detail'
    end
  end

  resources :messages, only: :create
  resources :queries, only: :create

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  match "/old_path_to_users/:id", to: redirect("/users/%{id}s"), via: :get
  match "/old_path_to_paintings/:id", to: redirect("/paintings/%{id}s"), via: :get

  get '/sitemap.xml' => 'sitemaps#index', defaults: { format: 'xml' }

  get "/robots.:format", to: "pages#robots"
end
