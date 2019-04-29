Rails.application.routes.draw do
  resources :inscriptions do
    collection do
      post 'confirmation'
      post 'set'
      post 'update_evaluation'
    end
    member do
      get 'release'
    end
  end 
  resources :languages
  resources :areas
  resources :schedules
  resources :evaluations do
    member do
      get 'confirm'
      post 'qualify'
    end
  end
  get '/users/evaluation'
  get '/users/destroy_record'
  post '/users/record_in_evaluation'


  resources :users do
    member do
      get 'reset_pw'
    end
  end

  resources :general_parameters, only: [:index] do
    collection do
      post 'set_value'
    end
  end


  resources :download, only: [:index] do
    member do 
      get 'make_inscription'
      get 'make_evaluation_list'
      get 'make_doc_approval'
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
