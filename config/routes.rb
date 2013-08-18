Friends::Application.routes.draw do
  resources :users do
    resources :friendships
  end
  resources :friendships
end
