Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  root "posts#index"
  get '/about', to: 'pages#about'
  get 'feed', to: 'feeds#rss', format: 'rss'
end
