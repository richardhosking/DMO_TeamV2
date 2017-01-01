Rails.application.routes.draw do
 
  get 'static_pages/home'
  get 'static_pages/help'
  get  'static_pages/about'
  get  'static_pages/contact'

  # Write in this format to fix error 
  # ArgumentError (Missing :controller key on routes definition, please check your routes.):
  root :to => 'static_pages#home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
