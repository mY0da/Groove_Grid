Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :songs, only: %i[index new create show]
end
