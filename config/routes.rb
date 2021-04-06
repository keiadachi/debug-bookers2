Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'

  get "home/about" => "homes#about"

  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end


  resources :users do
    member do
      get :followings, :followers # 今回追加したルーティング
    end
  end

  resources :relationships, only: [:create, :destroy]

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す


  get "search" => "searches#search"


  end