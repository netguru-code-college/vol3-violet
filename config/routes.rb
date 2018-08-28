Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:show, :index, :destroy]
  resources :groups do
    resources :bills
  end
  get 'group_bills_ajax/:id', to: 'groups#bills', as: 'group_bills_ajax'
  get 'users/:id/ban', to: 'users#ban', as: 'ban'
end
