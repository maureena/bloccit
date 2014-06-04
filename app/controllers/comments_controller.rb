class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = Comment.new
    
    
    authorize @comment
      if @comment.save
        redirect_to @post, notice: 'Comment was saved.'
      else
        flash[:error] = "There was a problem saving your comment. Please try again."
        render :new
      end
    end

end

private

def comment_params
  params.require(:comment).permit(:body, :post_id)
end