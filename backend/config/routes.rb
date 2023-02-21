Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:index]
  resources :sakes, only: [:index]
  get '/battles/all' , controller: :battles, action: :index
  post '/battle' , controller: :battles, action: :create
end
