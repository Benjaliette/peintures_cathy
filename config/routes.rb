Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :paintings, only: %i[index show new create] do
    resources :orders, only: %i[show create]
    resources :paiements, only: :new
  end
  resources :pages do
    collection do
      get 'contact'
      get 'artiste'
    end
  end

end
