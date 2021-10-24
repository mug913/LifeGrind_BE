Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :records
      resources :subareas
      resources :areas
      resources :users
      post '/login', to: 'users#login'
      get '/profile', to: 'users#user_profile'
    end
  end
end
