module SessionsHelper
  # Methods here are available to all controllers via an include in ApplicationController
  
  # Login a user
  def log_in(user)
    session[:user_id] = user.id
  end
 
  # Returns logged in user if there is one
  # uses the Rails ||= construct ie find @current_user once from DB if this has not already been done 
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end 
  
  def logged_in?
    !current_user.nil?
  end
      
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  
  
end
