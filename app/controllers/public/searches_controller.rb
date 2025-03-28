class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

def search
  @model = params[:model]
  @content = params[:content]
  @method = params[:method]
  
  # 選択したモデルに応じて検索を実行
  if @model  == "user"
    @records = User.active_users.search_for(@content, @method).page(params[:page]).per(8)
  else
    @records = Post.active_posts.search_for(@content, @method).page(params[:page]).per(4)
  end
 end
end
