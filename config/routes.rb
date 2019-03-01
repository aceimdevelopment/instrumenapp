Rails.application.routes.draw do
  resources :evaluations
  resources :languages
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get "home/index"
  get "home/minor"
  post "home/authenticate"

  resources :user_sessions, only: :index do
    # post 'actualizar_idiomas'
  end

  resources :admin_sessions, only: :index do
    # post 'actualizar_idiomas'
  end

	root to: 'home#index'  
end
