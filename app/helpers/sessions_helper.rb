module SessionsHelper
  # Methods here are available to all controllers via an include in ApplicationController
  
  # Login a user
  def log_in(user)
    session[:user_id] = user.id
  end
 
  # remember a user in a persistent session between logins
  def remember(user)
    user.remember 						# Class method to store token in DB
    cookies.permanent.signed[:user_id] = user.id		# Create a cookie with user id + end date permanent (20yr) and hash it
    cookies.permanent[:remember_token] = user.remember_token 	# add remember token 
  end
    
  # Returns logged in user if there is one
  # uses the Rails ||= construct ie find @current_user once from DB if this has not already been done 
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
	log_in user
	@current_user = user
      end
    end
  end
  
  
  def logged_in?
    !current_user.nil?
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  
  
end
