Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  resources :profiles, only: [:show, :edit, :update] do
    resources :works, only: [:index, :create, :edit, :update, :destroy]
  end

  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'
end
