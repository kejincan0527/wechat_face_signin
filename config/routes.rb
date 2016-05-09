Rails.application.routes.draw do

  root                               'static_pages#home'
  
  get                                'wechats/wx_valid'

  resources :scan_records, only: [:index, :new]
  resources :user, only: [:index, :new]
end
