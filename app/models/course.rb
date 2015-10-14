class Course < ActiveRecord::Base

  has_many :textbooks
  has_and_belongs_to_many :users


  validates :name, presence: true
end
