require 'test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  
  def setup
    @ken    = users(:ken)
    @peizhi = users(:peizhi)
    @textbook = textbooks(:supply_chain_management) # This textbook belongs to Peizhi
  end

  test "should notify a user when other users comment on his/her post" do
    log_in_as @ken
    get textbook_path(@textbook)
    assert_template 'textbooks/show'
    assert_difference 'Notification.count', 1 do
      post comment_path comment: { textbook_id: @textbook.id, message: "Can I buy this from you?" }
    end
    delete logout_path

    log_in_as @peizhi
    get user_path(@peizhi)
    assert_select 'span.notification_count', text: '1'
  end
end
