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
end
