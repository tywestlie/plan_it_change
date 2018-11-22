Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'user_token' => 'user_token#create'

  namespace :api do
    namespace :v1 do
      get '/authenticate', to: 'home#show'
      get '/home', to: 'home#index'

      # User routes
      get '/user_index', to: 'users#index'
      get '/user_show/:id', to: 'users#show'
      patch '/user_update/:id', to: 'users#update'
      post '/user_create', to: 'users#create'

      # Event routes
      get '/event_index', to: 'events#index'
      get '/event_show/:id', to: 'events#show'
      patch '/event_update/:id', to: 'events#update'
      post 'event_create', to: 'events#create'
    end
  end
end
