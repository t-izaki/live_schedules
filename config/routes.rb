Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  root to: 'top#index'
  resources :instruments, only: %i[index new create edit update destroy]
  resources :performers
  resources :monthly_schedules, only: %i[show edit update], param: :date

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :instruments, only: %i[index show]
      resources :performers, only: %i[index show]
      get 'monthly_schedules/:date', controller: :schedules, action: :index
      resources :schedules, only: %i[show], param: :date
    end
  end
end
