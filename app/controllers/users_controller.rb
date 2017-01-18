class UsersController < ApplicationController
  
  before_action :logged_in_user, only:[:index, :edit, :update]
  before_action :correct_user, only:[:edit, :update] 
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the DMO Team Management Software!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your Profile was successfully updated"
      redirect_to @user
    else
      flash[:warning] = "Update failed" 
      render 'edit'
    end
  end
  
  private
    # Prevent mass assignment - dont use params[:user] directly 
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :privileges)
    end
 
    # To restrict certain actions make sure user is logged in and is the correct one 
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Log in"
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
 
end
