Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  get "/homes/about" => "homes#about", as: "about"
  resources :books
  resources :users, only: [:show, :edit, :update]
end
