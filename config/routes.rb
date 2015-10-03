Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :profiles, only: [:show, :edit, :update] do
    resources :works, only: [:index, :create, :edit, :update, :destroy]
    member do
      get :following, :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]

  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'
  get '/search', to: 'profiles#search', as: 'search'
  get '/discovery', to: 'feeds#discover', as: 'discover'
  get '/collection', to: 'profiles#collection', as: 'collection'

  post '/add_piece', to: 'profiles#add_piece', as: 'add_piece'
  delete '/remove_piece', to: 'profiles#remove_piece', as: 'remove_piece'
end
