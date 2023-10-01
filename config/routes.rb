Rails.application.routes.draw do
  resources :podcasts, only: [:index, :show, :create, :new] do
    post :fetch_new_episodes, on: :member
    resources :episodes, controller: "podcast/episodes", only: [:index, :show]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "podcasts#index"
end
