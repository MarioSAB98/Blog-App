Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #session routes
  get "/login", to: "sessions#login"
  post "/login", to: "sessions#loginRequest"
  post "/logout", to: "sessions#logoutRequest"

  #user routes
  get "/signup", to: "users#create", as: :create_user
  post "/user", to: "users#createRequest", as: :users
  get "/user", to: "users#read", as: :read_users
  get "/user/update", to: "users#update", as: :update_user
  patch "/user", to: "users#updateRequest", as: :user
  delete "/user", to: "users#deleteRequest"
  
  #posts routes
  get "/home", to: "posts#index", as: :home
  get "/posts/create", to: "posts#create", as: :create_post
  post "/posts", to: "posts#createRequest", as: :posts
  get "/posts/:id", to: "posts#read", as: :read_post
  get "/posts/:id/update", to: "posts#update", as: :update_post
  patch "/posts/:id", to: "posts#updateRequest", as: :post
  delete "/posts/:id", to: "posts#deleteRequest"

  #comments routes
  get "/comments/create", to: "comments#create", as: :create_comments
  post "/posts/:id", to: "comments#createRequest", as: :comments
  get "/comments/:id", to: "comments#read", as: :read_comments
  get "/posts/:id/comments/:id/update", to: "comments#update", as: :update_comments
  patch "/comments/:id", to: "comments#updateRequest", as: :comment
  delete "/comments/:id", to: "comments#deleteRequest"
 

  
  # resources :posts (note for future: this can replace all the previous routes if I have followed the naming convention)

  # Defines the root path route ("/")
  root "sessions#login"
end
