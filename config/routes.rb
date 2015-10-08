Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :profiles, only: [:show, :edit, :update] do
    resources :works, only: [:index, :create, :edit, :update, :destroy]
    member do
      get :following, :followers
    end
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


  resources :relationships,       only: [:create, :destroy]

  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'
  get '/search', to: 'profiles#search', as: 'search'
  post '/search', to: 'profiles#search_results'

  get '/discovery', to: 'feeds#discover', as: 'discover'
  get '/messages/:user_id', to: 'messages#message_user', as: 'message_user'
  get '/feed', to: 'feeds#followingfeed', as: 'feed'
  post '/random', to: 'feeds#random', as: 'random'

  post '/most_collected', to: 'feeds#most_collected', as: 'most_collected'
  get '/collection', to: 'profiles#collection', as: 'collection'

  post '/add_piece', to: 'profiles#add_piece', as: 'add_piece'
  delete '/remove_piece', to: 'profiles#remove_piece', as: 'remove_piece'

  post '/color', to: 'colors#search'

end
