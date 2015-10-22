class NotificationsController < ApplicationController
  before_action :logged_in_user

  def reset
    Notification.update_seen(current_user)
    respond_to do |format|
      format.js 
    end
  end

end
