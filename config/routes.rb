Friends::Application.routes.draw do
  resources :users do
    resources :friendships, only: [:new, :create]
  end
  resources :friendships, only: [:destroy]
end
