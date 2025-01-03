class UsersController < ApplicationController
  def mypage
  end

  def edit
    @users = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

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

  
end
