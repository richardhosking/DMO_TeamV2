class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  # Methods available to all controllers 
  include SessionsHelper 
  
  private
  # To restrict certain actions make sure user is logged in and is the correct one 
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Log in"
      redirect_to login_url
    end
  end
end
