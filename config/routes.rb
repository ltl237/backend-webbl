Rails.application.routes.draw do
  resources :messages
  resources :users
  resources :follows
  resources :likings
  resources :comments
  resources :entries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
