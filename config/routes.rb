Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get 'pages/index'
  root 'pages#index'
end
