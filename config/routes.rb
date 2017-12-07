Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get 'pages/index'
  get 'retweet/:tweet_id', to: 'pages#retweet', as: :retweet
  get 'follow', to: 'pages#follow', as: :follow

  root 'pages#index'
end
