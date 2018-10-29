Rails.application.routes.draw do
  get 'geomap/geocontinent'
  get 'geomap/heatmap'
  get 'usersearches/new'
  get 'usersearches/index'
  get 'usersearches/edit'
  get 'usersearches/show'
  get 'news/index'
  get 'usersearches/search'
  get 'statistics/index'
  resources :countries
  resources :continents
  resources :categories
  resources :sources
  resources :usersearches
  # resources :geomap do
  #   resources :countries
  #   collection do
  #     get :map
  #   end
  # end

  root 'news#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
