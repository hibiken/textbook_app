class NotificationsController < ApplicationController
  before_action :logged_in_user

  def reset
    Notification.update_seen(current_user)
    respond_to do |format|
      format.js 
    end
  end

  def clear
    Notification.where(user_id: current_user.id).destroy_all
    redirect_to :back
  end

end
