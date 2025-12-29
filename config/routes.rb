Rails.application.routes.draw do
  root "plans#index"

  resources :recipes
  resources :meal_plans, only: %i[create update destroy]
  get "plans", to: "plans#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
