Rails.application.routes.draw do
  root "photos#index"

  # devise
  devise_for :users
  # resources
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  # keep this at the end
  get ":username/liked" => "users#liked", as: :liked_photos
  get ":username/feed" => "users#feed", as: :feed
  get ":username" => "users#show", as: :user
end
