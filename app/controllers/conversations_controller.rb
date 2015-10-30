class ConversationsController < ApplicationController
  def show
  end

  def create
    if Conversation.between(params[:buyer_id], params[:seller_id]).present?
      @conversation = Conversation.between(params[:buyer_id], params[:seller_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

    def conversation_params
      params.permit(:buyer_id, :seller_id)
    end
end
