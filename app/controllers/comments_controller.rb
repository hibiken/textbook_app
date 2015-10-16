class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    textbook = Textbook.find(params[:comment][:textbook_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to textbook 
    else
      flash[:danger] = "Something went wrong when posting your comment. Please try again."
      render 'textbooks/show'
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:message, :textbook_id)
    end

end
