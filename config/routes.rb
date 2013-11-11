TrentoCarSharing::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  authenticated :user do
    root :to => "home#dashboard"
  end
  unauthenticated :user do
    devise_scope :user do 
      get "/" => "devise/registrations#new"
    end
  end

  # resources :users
  namespace :api, defaults: {format: :json} do
    resources :teams do
      resources :car_requests
      resources :drivers
    end
  end

  get "dashboard" => "home#dashboard"
  get "templates/:template_name" => "templates#show"

  post "driver" => "api/drivers#file_upload"
  post "api/teams/:id/finish" => "api/teams#finish"
  post "api/teams/:team_id/drivers/:driver_id/documents" => "uploads#create"
  post "api/teams/:team_id/drivers/documents" => "uploads#create"
  delete "api/teams/:team_id/drivers/:driver_id/documents/:id" => "uploads#delete"
end