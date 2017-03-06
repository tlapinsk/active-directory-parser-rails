Rails.application.routes.draw do
  get 'welcome/index'
  resources :welcome do
  	collection do
  		post 'import'
  		post 'report'
  	end
  end

  resources :users
  resources :jobs
  resources :groups

  root 'welcome#index'
end
