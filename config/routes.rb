Rails.application.routes.draw do
  devise_for :users, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  
  scope module: :public do
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/search", to: "searches#search"

  resources :posts, only: [:new, :create, :destroy, :index, :show, :edit, :update] do
    resources :comments, only: [:index, :show, :create, :destroy, :update]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:mypage, :show, :destroy, :update, :edit, :index] do
    resource :relationships, only: [:create, :destroy]
    resources :favorites, only: [:index]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts_type, only: [:index, :show, :create, :destroy, :update]
  resources :chats, only: [:create, :destroy, :index, :show]
  resources :bookmarks, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy, :followings, :followers]
  resources :chats, only: [:show, :create]
end
  

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    get 'dashboards', to: 'dashboards#show'
    resource :users, only: [:destroy]
  end
end
