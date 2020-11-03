Rails.application.routes.draw do
  devise_for :users
  root to: "goods#index"
    resources :goods do 
    resources :purchases_infos,only: [:new,:create]
  end
end

