Rails.application.routes.draw do
  get '/health', to: 'health#health'

  resources :posts, only: [:index, :show, :create, :update]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
