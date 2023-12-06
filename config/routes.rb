Rails.application.routes.draw do

  devise_for  :users, :controllers => { :registrations => "registrations" }

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "welcome_page", to: "pages#welcome_page", as: :welcome_page
  get "welcome_video", to: "pages#welcome_video", as: :welcome_video

  resources :songs, except: [:destroy]

  resources :songs do
    member do
      post 'add_tag'
      post 'remove_tag'
    end
    resources :tag_songs, only: %i[destroy]
  end

  resources :profiles, controller: 'profiles'

  resources :playlists do
    resources :playlist_songs, only: %i[new create destroy]
    collection do
      get :search
    end
  end

  resources :tags
  resources :playlist_songs, only: :destroy
  end
