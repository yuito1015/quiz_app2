Rails.application.routes.draw do
  root "homes#top"
  get "/about", to: "homes#about"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :follows, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :quizzes, only: [:index, :show, :new, :create]
  post "/answer/:id", to: "quizzes#answer", as: "answer"
end
