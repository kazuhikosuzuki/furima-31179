Rails.application.routes.draw do
  devise_for :users
  root to: "goods#index"
  resources :purchases_infos,only: [:create]
  resources :goods do 
    resources :purchases, only: [:index,:create]
end
end

