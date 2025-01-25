class Public::CommentsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントが正常に保存されました！"
      redirect_to request.referer
    else flash.now[:alert] = "コメントの保存に失敗しました。" 
      @user = @post.user
      @posts = @user.posts
      render 'posts/show'
      <!-- 変数について、基本は必ず＠をつけて受け渡しできるようにする -->
      <!-- コメントの引数にUserとPostがなかったので気を付ける -->
    end
  end

  def update
  end

  def destroy
    post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id]).destroy
    redirect_to post_path(post)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
