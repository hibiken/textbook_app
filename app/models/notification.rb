class Notification < ActiveRecord::Base
  belongs_to :user

  validates :use_id, :message, presence: true
end
