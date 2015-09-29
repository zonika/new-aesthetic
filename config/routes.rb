Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations' }
  get '/', to: 'home#index'
  get '/about', to: 'home#about', as: 'about'
end
