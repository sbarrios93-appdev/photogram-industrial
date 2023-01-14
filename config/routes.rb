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
  get "/:username" => "users#show"
end
