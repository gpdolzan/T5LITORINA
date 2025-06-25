Rails.application.routes.draw do
  root 'home#index'
    # Authentication routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  # Resources
  resources :users
  
  resources :professors
  
  resources :rooms do
    member do
      get 'confirm_reassign'
    end
  end
  
  resources :disciplines do
    member do
      post 'enroll'
      delete 'unenroll'
    end
  end
end
