Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  resources :posts
  resources :comments

  post "/auth/login", to: "authentication#login"

end
