Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  post '/' => 'home#calculate', as: 'calculate'
  resources :people, except: :show
end
