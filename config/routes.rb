Rails.application.routes.draw do
	require 'sidekiq/web'
	mount Sidekiq::Web, at: '/sidekiq'

  mount Base => '/api'
  
  root                               'static_pages#home'

  get  'user_profile'             => 'users#profile'
  
  get  'wechats/authorize'        => 'wechats#authorize'
  get  'wechats/wx_receive'       => 'wechats#wx_valid'
  post 'wechats/wx_receive'       => 'wechats#wx_receive'

  resources :records,                 only: [:index, :new]
  resources :users,                   only: [:index, :new, :create, :edit, :update]
end
