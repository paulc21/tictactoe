Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :games, only: [:index,:create,:show]
  resources :sessions, only: [:new,:create]

  root 'sessions#new'
end
