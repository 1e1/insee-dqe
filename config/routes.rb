Rails.application.routes.draw do
  resources :tile_groups
  resources :tiles
  root 'landing#default'

  namespace :public do
  end

  namespace :api do
    get '/address', to: 'address#search'

    resource :tiles, only: [:index, :delete]

    get '/tile', to: 'tiles#search'
    post '/tiles/csv', to: 'tiles#csv'
    post '/tile_groups/csv', to: 'tile_groups#csv'
  end
end
