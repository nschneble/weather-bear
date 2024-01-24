Rails.application.routes.draw do
  resources :lookups

  # health status that returns 200 if the app boots with no exceptions
  # can be used to verify the app is live
  get 'up' => 'rails/health#show', as: :rails_health_check

  # defines the root path route ('/')
  root 'public#index'
end
