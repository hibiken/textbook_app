class CommentsController < ApplicationController
  before_action :logged_in_user
  after_action  :push_notification, only: :create

  def create
    @textbook = Textbook.find(params[:comment][:textbook_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @textbook 
    else
      flash[:danger] = "Something went wrong when posting your comment. Please try again."
      render 'textbooks/show'
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:message, :textbook_id)
    end

    def  push_notification
      message = "#{current_user.name} commented on your listing."
      Notification.create(user_id: @textbook.user.id, message: message, path: textbook_path(@textbook))
    end


end
