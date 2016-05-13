Rails.application.routes.draw do
  
  get 'events/new'

  get 'events/create'

  get     'signup'        => 'users#new'
  get     'login'         => 'sessions#new'
  post    'login'         => 'sessions#create'
  delete  'logout'        => 'sessions#destroy'
  get     'create_event'  => 'events#new'
  post    'create_event'  => 'events#create'
  get     'event_index'   => 'events#index'
  root                       'sessions#new'
  
 
  resources :users
  resources :events
  resources :invites
  
end


