class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  # Methods available to all controllers 
  include SessionsHelper 
  
end
