Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :profiles, only: [:show, :edit, :update] do
    resources :works, only: [:index, :create, :edit, :update, :destroy]
  end
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]


  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'
  get '/search', to: 'profiles#search', as: 'search'
  get '/discovery', to: 'feeds#discover', as: 'discover'
  get '/messages/:user_id', to: 'messages#message_user', as: 'message_user'
  get '/collection', to: 'profiles#collection', as: 'collection'
  post '/add_piece', to: 'profiles#add_piece', as: 'add_piece'
  delete '/remove_piece', to: 'profiles#remove_piece', as: 'remove_piece'

end
