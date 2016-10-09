Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :words
  resources :weeks
  root to: 'words#index'
  get '/wordlist/', to: 'words#wordlist', as: 'wordlist'
  get '/spellingbee', to: 'words#spellingbee', as: 'spellingbee'
  get '/randombee', to: 'words#randombeewords', as: 'randombee'
  get '/words/newbee', to: 'words#newbee', as: 'newbee'
  post '/words', to: 'words#create_bee_words'

  post 'words/voice' => 'words#voice'
end
