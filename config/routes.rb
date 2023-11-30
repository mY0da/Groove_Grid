Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  
  resources :profiles, controller: 'profiles'

  get "dashboard", to: "pages#dashboard", as: :dashboard

  resources :songs, only: %i[index new create show]
end
