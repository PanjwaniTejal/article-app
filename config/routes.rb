Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :registrations, only: [:create, :destroy] do
    post 'confirm', on: :collection
  end
  resources :sessions, only: [ :create, :destroy ]
  resources :articles, only: [ :create, :show ]
end
