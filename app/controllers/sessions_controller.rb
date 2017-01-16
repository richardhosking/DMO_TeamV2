class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
	#Log user in
	log_in user
	redirect_to clients_path
      else
	# display error and redirect to login page
	flash.now[:danger] = 'Invalid email and password combination'
	render 'new'
      end
  end

  def destroy
  end
  
end
