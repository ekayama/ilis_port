class UsersController < ApplicationController
  def mypage
  end

  def edit
    @users = Users.find(params[:id])
  end

  def show
    @users = Users.find(params[:id])
    @post = @users.post
  end

  def update
    @users = Users.find(params[:id])
    if @users.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
  end



  private

  def user_params
    params.require(:users).permit(:name, :profile_image)
  end

  
end
