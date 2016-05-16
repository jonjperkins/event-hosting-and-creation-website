Rails.application.routes.draw do
  
  get 'static_pages/home'

  get 'static_pages/about'

  get 'events/new'

  get 'events/create'

  get     'signup'        => 'users#new'
  get     'login'         => 'sessions#new'
  post    'login'         => 'sessions#create'
  delete  'logout'        => 'sessions#destroy'
  get     'create_event'  => 'events#new'
  post    'create_event'  => 'events#create'
  get     'event_index'   => 'events#index'
  root                       'static_pages#home'
  
 
  resources :users
  resources :events
  resources :invites
  
end


