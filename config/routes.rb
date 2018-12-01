Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  root to: 'top#index'
  resources :instruments, only: %i[index new create edit update destroy]
end
