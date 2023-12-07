Rails.application.routes.draw do

  devise_for  :users, :controllers => { :registrations => "registrations" }

  root to: "pages#home"

  get "dashboard", to: "pages#dashboard", as: :dashboard
  get "welcome_page", to: "pages#welcome_page", as: :welcome_page
  get "welcome_video", to: "pages#welcome_video", as: :welcome_video
  # get '/download_playlist' => 'playlists#download_mp3'

  resources :songs

  resources :songs do
    member do
      post 'add_tag'
      # post 'remove_tag'
    end
  end
  resources :tag_songs, only: %i[destroy], as: "destroy_tag"

  resources :profiles, controller: 'profiles'

  resources :playlists do
    resources :playlist_songs, only: %i[new create destroy]

    collection do
      get :search
    end

    member do
      get :download
    end
  end

  resources :tags
  resources :playlist_songs, only: :destroy
  end
