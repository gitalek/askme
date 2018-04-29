Rails.application.routes.draw do
  root 'users#index'
  resources :users, except: %i[destroy]
  resources :sessions, only: %i[new create destroy]
  resources :questions, except: %i[show new index]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'show' => 'users#show'
  # get 'bla' => 'users#moo'
end
