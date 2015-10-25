class CommentsController < ApplicationController
  before_action :logged_in_user
  after_action  :notify_seller,     only: :create
  after_action  :notify_commenters, only: :create

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



    # TODO: move these to background jobs?

    def notify_seller
      unless current_user?(@textbook.user)
        message = "#{current_user.name} commented on your listing for #{@textbook.title}"
        Notification.create(user_id: @textbook.user.id, message: message, path: textbook_path(@textbook))
      end
    end


    def notify_commenters
      message = "#{current_user.name} also left a comment for #{@textbook.title}"
      @textbook.commenters.each do |user|
        if (user != current_user) && (user != @textbook.user) 
          Notification.create(user_id: user.id, message: message, path: textbook_path(@textbook))
        end
      end
    end


end
