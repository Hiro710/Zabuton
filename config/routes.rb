Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  # ログイン画面から送られるメアドやパスワードを使ってログインを実行
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  root to: 'oogiri_events#index'
  resources :oogiri_events do
    # 確認画面 /oogiri_events/new/confirm というURLをconfirm_newアクションに対応付ける
    post :confirm, action: :confirm_new, on: :new
  end

end
