class CommentsController < ApplicationController
  before_action :not_logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "コメントを作成しました"
      redirect_to @post
    else
      @comments = @post.comments.page(params[:page])
      render "posts/show"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back fallback_location: @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.nil? && !current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_back fallback_location: @comment.post
    end
  end
end
