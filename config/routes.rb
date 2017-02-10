Rails.application.routes.draw do
  # Registration & Login Routes
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "/register" => "users#new"

  # Root Path
  root "staticpages#home"

  # Dashboard
  get "/dashboard" => "staticpages#dashboard"
  get "/client-dashboard" => "staticpages#client_dashboard"

  # Nested routes for
  resources :users do
    resources :clients
  end

  # resources :exercise_images
  resources :exercises, :trainings

  # Special edits for trainers
  delete "/remove-exercise" => "exercises#remove" # Remove exercise from a training
  post "/training-geven" => "trainings#assign_training" # Add active training to client
  delete "/training-verwijderen" => "trainings#remove_training" # Remove active training from client

  post "/training-afwerken" => "trainings#complete_training"
end
