class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :set_conversation

  def index
    @conversation.mark_as_read_for!(current_user)
    @messages = @conversation.messages
    if current_user?(@conversation.buyer)
      @receipient = @conversation.seller
    else
      @receipient = @conversation.buyer
    end
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      @conversation.update(updated_at: Time.zone.now)
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:danger] = "Something went wrong. Please try again."
      redirect_to conversation_messages_path(@conversation)
    end
  end


  private

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
