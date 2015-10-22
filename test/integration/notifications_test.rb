require 'test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  
  def setup
    @ken    = users(:ken)
    @peizhi = users(:peizhi)
    @textbook = textbooks(:intro_to_accounting) # This textbook belongs to Peizhi
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
    # Click in on the bell icon will clear the counter
    xhr :post, reset_notification_path
    assert_select 'span.notification_count', count: 0  
  end

  test "should notify a user when other user post textbook he/she put in her wishlist" do
    log_in_as @ken 
    get wishlist_path
    assert_template 'courses/index'
    get new_course_path
    post courses_path course_id: 1
    assert_redirected_to wishlist_url
    delete logout_path

    log_in_as @peizhi 
    get new_textbook_path
    assert_difference 'Notification.count' do 
      post textbooks_path textbook: { title: 'Good essay', price: 30.99, description: 'You need this.', subject_id: 1, course_id: 1 }
    end
    assert_redirected_to @peizhi 
    delete logout_path

    log_in_as @ken
    get users_path(@ken)
    assert_select 'span.notification_count', text: '1'
    # Click in on the bell icon will clear the counter
    xhr :post, reset_notification_path
    assert_select 'span.notification_count',count: 0
  end


end
