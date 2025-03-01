class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :index]
  before_action :reject_deleted_user, only: [:show]

  def mypage
  end

  def release
    @user =  User.find(params[:id])
    @user.released! unless @user.released?
    redirect_to edit_user_path(@user), notice: 'このアカウントを公開しました'
  end

  def nonrelease
    @user =  User.find(params[:id])
    @user.nonreleased! unless @user.nonreleased?
    redirect_to edit_user_path(@user), notice: 'このアカウントを非公開にしました'
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8)
    #@posts = Post.where(user_id: @user.id)
  end

  def index
    @users = User.all
    @post = Post.new
    @posts = Post.all.page(params[:page]).per(8)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "失敗しました。"
      render :edit
      # flashの[:notice]と[:alert]の違いはほぼない。c ssで装飾したいかどうかの違い -->
      # flash.nowは画面が変わってから表示するのではなく、そのまま強制的に表示するもの -->
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :profile_image, :profile_description)
    # ユーザー編集したときに情報が保存されかった理由は、このpermitに保存する情報を記載してなかったから。
        # permit（）の中にある項目が保存許可されてる情報 -->
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def reject_deleted_user
    @user = User.find(params[:id])
    redirect_to root_path if @user.is_deleted
  end
end
