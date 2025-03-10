class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(6)
    #@users = User.all
  end

  def show
    @users = User.find(params[:user_id])
    @posts = @user.posts
  end
end
  