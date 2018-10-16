Rails.application.routes.draw do
  get 'usersearches/new'
  get 'usersearches/index'
  get 'usersearches/edit'
  get 'usersearches/show'
  get 'news/index'
  resources :countries
  resources :continents
  resources :categories
  resources :sources
  resources :usersearches
  root 'news#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
