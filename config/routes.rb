Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  namespace :api do
    namespace :v1 do
      get '/authenticate', to: 'home#show'
      get '/home', to: 'home#index'
      get '/user_index', to: 'users#index'
      get '/user_show', to: 'users#show'
      patch '/user_update/:id', to: 'users#update'
      post '/user_create', to: 'users#create'
    end
  end
end
