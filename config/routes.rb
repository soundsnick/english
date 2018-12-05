Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'app#home'
  get '/about', to: 'app#about', as: :about
  get '/login', to: 'user#login_page', as: :login
  # get '/register', to: 'user#register_page', as: :register
  get '/logout', to: 'user#logout', as: :logout
  get '/category/:id(.:format)', to: 'app#category'
  get '/video/:id(.:format)', to: 'app#video'

  post '/login', to: 'user#login'
  # post '/register', to: 'user#register'
end
