Rails.application.routes.draw do
 
  get '/signup', to: 'users#new'

  get '/help', to: 'static_pages#help'
  get  '/about', to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  
  resources :users
  
  # Write root route in this format to fix error 
  # ArgumentError (Missing :controller key on routes definition, please check your routes.):
  root :to => 'static_pages#home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
