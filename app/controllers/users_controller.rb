class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :index]
  
  def mypage
  end

  def edit
    @users = User.find(params[:id])
    unless @users.id == current_user.id
      redirect_to new_user_session_path
    end
   
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
    @post = Post.new
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to new_user_registration_path
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile_description)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end 

end
