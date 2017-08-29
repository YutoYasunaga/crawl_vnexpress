Rails.application.routes.draw do
  root 'articles#index'

  resources :articles

  get '/reload' => 'articles#reload', as: 'reload'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
