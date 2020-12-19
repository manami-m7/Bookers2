Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about", as: "about"
  resources :homes
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    member do
      get :followed, :followers
    end
  end

  resources :relationships, :only => [:create, :destroy]


end
