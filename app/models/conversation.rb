class Conversation < ActiveRecord::Base
  belongs_to :buyer,  class_name:   'User',
                      foreign_key:  'buyer_id'
  belongs_to :seller, class_name:   'User',
                      foreign_key:  'seller_id'

  has_many :messages, dependent: :destroy

  scope :between, ->(buyer_id, seller_id) do
    where("(conversations.buyer_id = ? AND conversations.seller_id = ?) OR 
           (conversations.buyer_id = ? AND conversations.seller_id = ?)", buyer_id, seller_id, seller_id, buyer_id)
  end

  def user_other_from(user)
    if buyer_id == user.id 
      seller 
    else
      buyer 
    end
  end

  def mark_as_read_for!(user)
    messages.each do |message|
      message.update(read: true) if message.user_id != user.id
    end
  end
end
