Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  resources :songs, only: [:index, :new, :create, :show]

  resources :profiles, only: [:new,:create]

end
