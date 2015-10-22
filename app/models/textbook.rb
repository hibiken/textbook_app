class Textbook < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :course
  has_many :comments, dependent: :destroy


  validates :title, presence: true, length: { maximum: 70 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000 } 
  validates :subject_id, presence: true
  validates :course_id, presence: true

  default_scope -> { order(created_at: :desc) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  # Query all textbook with a given string included in either title or description.
  scope :search, ->(search) { where("title LIKE :search OR description LIKE :search", search: "%#{search}%") }



  def course_name
    course.name 
  end

  def subject_name
    subject.name
  end

end
