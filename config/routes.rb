Rails.application.routes.draw do
  resources :countries
  resources :continents
  resources :categories
  resources :sources
  root 'under_construction#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
