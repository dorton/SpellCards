Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :words do
    collection { post :import }
  end
  resources :weeks
  root to: 'words#index'
  get '/wordlist', to: 'words#wordlist', as: 'wordlist'
  get '/spellingbee', to: 'words#spellingbee', as: 'spellingbee'
  get '/randombee', to: 'words#randombeewords', as: 'randombee'
  get '/newbee/new', to: 'words#newbee', as: 'newbee'
  post '/newbee', to: 'words#createbee'
end
