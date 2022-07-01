Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :peintures, only: %i[index show new create]
  resources :pages do
    collection do
      get 'contact'
      get 'artiste'
    end
  end
end
