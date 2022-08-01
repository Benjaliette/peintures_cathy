Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: "pages#home"

  resources :paintings, only: %i[index show new create] do
    resources :orders, only: %i[show create]
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

  resources :users, only: :show

  resources :messages, only: :create
end
