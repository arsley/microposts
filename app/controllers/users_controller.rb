class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Microposts!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    if current_user != User.find(params[:id])
      flash[:danger] = "You don't have authority to do this."
      redirect_to root_path
    elsif logged_in?
      @user = User.find(params[:id])
    else
      flash[:danger] = "To do that thing, please log in."
      redirect_to login_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Edit completed!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :location, :hobby, :introduce)
  end
end
