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
      delete '/user_delete/:id', to: 'users#destroy'

      # Event routes
      get '/event_index', to: 'events#index'
      get '/event_show/:id', to: 'events#show'
      patch '/event_update/:id', to: 'events#update'
      post '/event_create', to: 'events#create'
      delete '/event_delete/:id', to: 'events#destroy'

      # Post routes
      get '/post_index', to: 'posts#index'
      get '/post_show/:id', to: 'posts#show'
      patch '/post_update/:id', to: 'posts#update'
      post '/post_create', to: 'posts#create'
      delete '/post_delete/:id', to: 'posts#destroy'

      # Comment routes
      get '/comment_index', to: 'comments#index'
      get '/comment_show/:id', to: 'comments#show'
      patch '/comment_update/:id', to: 'comments#update'
      post '/comment_create', to: 'comments#create'
      delete '/comment_delete/:id', to: 'comments#destroy'
    end
  end
end
