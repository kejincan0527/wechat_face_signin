Rails.application.routes.draw do
	require 'sidekiq/web'
	mount Sidekiq::Web, at: '/sidekiq'

  mount Base => '/api'
  
  root                               'static_pages#home'
  
  get  'wechats/wx_receive'       => 'wechats#wx_valid'
  post 'wechats/wx_receive'       => 'wechats#wx_receive'

  resources :records,                 only: [:index, :new]
  resources :users,                   only: [:index, :new, :create, :edit, :update]
end
