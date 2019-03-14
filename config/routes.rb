Rails.application.routes.draw do
  resources :areas
  resources :evaluations do
    member do
      get 'confirm'
    end
  end
  resources :languages
  get '/users/evaluation'
  get '/users/destroy_record'
  post '/users/record_in_evaluation'


  resources :users do
    member do
      get 'reset_pw'
      post 'record_confirmation'
    end
  end

  resources :download, only: [:index] do
    member do 
      get 'make_inscription'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


	# get "home/index"

  resource :home, only: :index do
    post 'authenticate', to: 'home#authenticate'
    get 'logout', to: 'home#logout'
    get 'index', to: 'home#index'  
  end

  resource :students_session, only: :index do
    get 'index', to: 'students_session#index'
  end

  resource :admins_session, only: :index do
    get 'index', to: 'admins_session#index'
  end

	root to: 'home#index'  
end
