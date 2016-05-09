Rails.application.routes.draw do
	require 'sidekiq/web'
	mount Sidekiq::Web, at: '/sidekiq'

  mount Base => '/api'
  
  root                               'static_pages#home'
  
  get                                'wechats/wx_valid'

  resources :scan_records,           only: [:index, :new]
  resources :user,                   only: [:index, :new]
end
