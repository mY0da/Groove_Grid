Rails.application.routes.draw do

  devise_for  :users, :controllers => { :registrations => "registrations" }

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "welcome_page", to: "pages#welcome_page", as: :welcome_page
  get "welcome_video", to: "pages#welcome_video", as: :welcome_video

  resources :songs, only: %i[index new create show]
  resources :profiles, controller: 'profiles'
end
