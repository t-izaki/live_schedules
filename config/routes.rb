Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  root to: 'top#index'
  resources :instruments, only: %i[index new create edit update destroy]
  resources :performers
  resources :monthly_schedules, only: %i[show edit update], param: :date
end
