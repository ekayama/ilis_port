class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorites = current_user.favorites.new(post_id: @post.id)
    @favorites.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    redirect_to request.referer
  end 
 
  def index
    #byebug　↓ここ編集
    @user = User.find(params[:user_id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end

end
