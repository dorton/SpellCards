Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :words
  resources :weeks
  root to: 'words#index'
  get '/wordlist/', to: 'words#wordlist', as: 'wordlist'
  post 'words/voice' => 'words#voice'
end
