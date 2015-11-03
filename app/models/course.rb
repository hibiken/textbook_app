class Course < ActiveRecord::Base
  has_many :textbooks
  has_and_belongs_to_many :users
  belongs_to :subject


  validates :name, presence: true

  # Returns the course without the number. CSC223 returns CSC
  def prefix
    name[0,3]
  end
end
