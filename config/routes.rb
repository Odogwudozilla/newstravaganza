Rails.application.routes.draw do
  get 'geomap/geocontinent'
  get 'geomap/heatmap'
  get 'geomap/geocountries'

  get 'news/index'

  get 'statistics/index'
  get 'usersearches/new'
  get 'usersearches/index'
  get 'usersearches/edit'
  get 'usersearches/show'
  get 'usersearches/create'
  get 'usersearches/search'

  resources :countries
  resources :continents
  resources :categories
  resources :sources

  resources :usersearches do

  end


  # resources :geomap do
  #   resources :countries
  #   collection do
  #     get :map
  #   end
  # end

  root 'news#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
