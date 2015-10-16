class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :textbook

  
  validates :message, :user_id, :textbook_id, presence: true
end
