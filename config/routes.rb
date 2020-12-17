Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about", as: "about"
  resources :homes
  resources :books do
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users
end
