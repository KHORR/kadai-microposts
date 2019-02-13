Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    # 中間テーブルから先にある、フォロー中のユーザーとフォローされている
    # ユーザー一覧を表示させるためのコード
    member do
      get :followings
      get :followers
      get :likes
      # 中間テーブルから先にある、フォロー中の投稿を表示させるコード?
      get :like_followings
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  resources :likes, only: [:create, :destroy] do
# 中間テーブルから先にある、お気に入りしているユーザ一覧を表示させるコード？
    # member do
        # get :like_followers
    # end
   end
end