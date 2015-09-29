Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :works, only: [:index, :create, :edit, :update, :destroy]
  end
  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'

  get '/portfolio', to: 'works#index', as: 'portfolio'
end
