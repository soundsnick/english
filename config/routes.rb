Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'app#home'
  get '/about', to: 'app#about', as: :about
  get '/login', to: 'user#login_page', as: :login
  get '/register', to: 'user#register_page'
  get '/logout', to: 'user#logout', as: :logout
  get '/category/:id(.:format)', to: 'app#category'
  get '/video/:id(.:format)', to: 'app#video'
  get '/admin', to: 'app#admin', as: :admin
  get '/remove/:id(.:format)', to: 'app#remove'
  get '/add', to: 'app#add', as: 'add'
  get '/add/:id(.:format)', to: 'app#addTwo'
  get '/edit/:id(.:format)', to: 'app#edit', as: 'edit'
  get '/course/create', to: 'app#newCourse'
  get '/course/create/:id(.:format)', to: 'app#newCourseTwo'
  get '/course/edit/:id(.:format)', to: 'app#editCourse'
  get '/course/buy/:id(.:format)', to: 'app#buyCourse'
  get '/course/:id(.:format)', to: 'app#coursePage'

  post '/edit', to: 'app#editVideo'
  post '/login', to: 'user#login'
  post '/add', to: 'app#addVideo'
  post '/category/add', to: 'app#categoryAdd'
  get '/category/remove/:id(.:format)', to: 'app#categoryRemove'
  post '/course/create', to: 'app#newCoursePost'
  post '/course/edit', to: 'app#editCoursePost'
  post '/register', to: 'user#register'
end
