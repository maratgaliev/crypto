Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :encrypted_strings, param: :token, except: [:update, :edit, :new]
  post :data_encrypting_keys, to: 'data_encrypting_keys#rotate', path: '/data_encrypting_keys/rotate'
  get :data_encrypting_keys, to: 'data_encrypting_keys#status', path: '/data_encrypting_keys/rotate/status', as: :job_status
end
