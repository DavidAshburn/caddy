Rails.application.routes.draw do

  #trim these down later
  resources :discs, :courses, :disckeys, :coursekeys, :cards
  devise_for :users
  root 'home#index'
  get 'home/discbag'
  get 'home/courses'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
