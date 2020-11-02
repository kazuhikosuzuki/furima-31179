Rails.application.routes.draw do
  devise_for :users
  root to: "goods#index"
    resources :goods do 
      member do
      post 'order'
      end
    resources :purchases_infos,only: [:new,:create]
    resources :purchases, only: [:create]
end
end

