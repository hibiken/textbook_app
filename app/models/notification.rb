class Notification < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :message, :path, presence: true

  default_scope -> { order(created_at: :desc) }


  def self.update_seen(user)
    self.where(user_id: user.id).find_each do |notification|
      notification.seen = true
      notification.save
    end
  end

end
