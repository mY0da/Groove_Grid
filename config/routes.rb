Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "welcome_page", to: "pages#welcome_page", as: :welcome_page
  get "welcome_video", to: "pages#welcome_video", as: :welcome_video

  resources :songs, only: [:index, :new, :create, :show]
end
