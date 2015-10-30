require 'test_helper'

class ConversationBetweeenUsersTest < ActionDispatch::IntegrationTest
  
  def setup
    @ken   = users(:ken)
    @aaron = users(:aaron)
    @kens_textbook   = textbooks(:ruby_on_rails_tutorial)
    @aarons_textbook = textbooks(:intro_to_marketing)
    log_in_as @ken
  end

  test "should display 'message seller' button in other users textbooks show page" do
    get textbook_path(@aarons_textbook)
    assert_template 'textbooks/show'
    assert_select 'form[action=?]', conversations_path(buyer_id: @ken.id, seller_id: @aaron.id)

    # creates a new conversation between Ken and Aaron
    assert_difference 'Conversation.count', 1 do
      post conversations_path, buyer_id: @ken.id, seller_id: @aaron.id
    end
    conversation = assigns(:conversation)
    assert_redirected_to conversation_messages_path(conversation)
    follow_redirect!
    assert_template 'messages/index'

    # message form
    assert_select '#message_form'
    assert_difference 'Message.count', 1 do
      post conversation_messages_path, message: { body: 'Can I buy your textbook?', user_id: @ken.id }   
    end
    conversation = assigns(:conversation)
    assert_redirected_to conversation_messages_path(conversation)   
  end

  test "should not display 'message seller' button in current user's textbook show page" do
    get textbook_path(@kens_textbook)
    assert_template 'textbooks/show'
    assert_select 'form[action=?]', conversations_path(buyer_id: @ken.id, seller_id: @ken.id), count: 0
  end

end
