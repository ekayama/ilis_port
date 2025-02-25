class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to post_path(@post)
      else
        render :new
      end
    end
  
    def index
      @posts = Post.active_posts
    end
  
    def show
      @post = Post.find(params[:id])
      @user = @post.user
      @posts = @user.posts
      @comment = Comment.new

    end
  
    def edit
      @post = Post.find(params[:id])
      # postを投稿したユーザーだけが編集できるようにする
      unless @post.user.id == current_user.id
        redirect_to posts_path
      end
    end
  
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to post_path(@post)
      else
        render :edit
        end
    end
  
    def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to posts_path
    end
  
    private
  
    def post_params
      params.require(:post).permit(:users_id, :posts_type_id, :image, :title, :body, :media_url)
    end

    def ensure_correct_user
      post = Post.find(params[:id])
      unless post.user.id == current_user.id
        redirect_to posts_path
      end
    end 

end