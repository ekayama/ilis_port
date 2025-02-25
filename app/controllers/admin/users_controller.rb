class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(is_deleted: false)
    flash[:notice] = "success"
    redirect_to admin_user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    #@user.destroy
    @user.update(is_deleted: true)
    #redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    flash[:notice] = "ユーザーを削除しました。"
    redirect_to admin_user_path(@user)
  end
end
