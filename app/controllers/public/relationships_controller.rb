class Public::RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @records = user.followings.page(params[:page]).per(5)
  end

  def followers
    user = User.find(params[:user_id])
    @records = user.followers.page(params[:page]).per(5)
  end
end
