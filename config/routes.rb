Rails.application.routes.draw do
  get 'import/json'
  get '/search', to: 'import#search'
  get '/showsubcategories', to: 'import#showsubcategories'
  get '/showidcategory', to: 'import#showidcategory'
  # get 'welcome/index'

  resources :subcategories do
    resources :subcategories
  end

  #root 'welcome#index'
  root 'import#json'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
