TrentoCarSharing::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  namespace :api, defaults: {format: :json} do
    resources :teams do
      resources :car_requests
      resources :drivers
    end
  end

  get "dashboard" => "home#dashboard"
  get "templates/:template_name" => "templates#show"
end