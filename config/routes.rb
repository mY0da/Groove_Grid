Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  resources :songs, only: [:index, :new, :create, :show]

  resources :profiles, controller: 'profiles'

end
