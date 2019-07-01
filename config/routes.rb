Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      resources :conversations
      resources :messages
      resources :users
      resources :follows
      resources :likings
      resources :comments
      resources :entries

      post '/login', to: 'auth#login'
      post '/users', to: 'users#index'
      get '/profile', to: 'users#profile'
      get "/auto_login", to: "auth#auto_login"
      mount ActionCable.server => '/cable'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
