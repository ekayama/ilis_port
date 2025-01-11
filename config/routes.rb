Rails.application.routes.draw do
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  devise_for :users, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  
  devise_for :admins, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "admins/registrations",
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    confirmations: "admins/confirmations"
  }

  resources :users, only: [:mypage, :show, :destroy, :update, :edit, :index]
  resources :posts, only: [:new, :create, :destroy, :index, :show, :edit, :update]
  resources :posts_type, only: [:index, :show, :create, :destroy, :update]
  resources :comments, only: [:index, :show, :create, :destroy, :update]
  resources :chats, only: [:create, :destroy, :index, :show]
  resources :bookmarks, only: [:create, :destroy]
  resources :favorite, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy, :followings, :followers]

  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/search", to: "searches#search"

end
