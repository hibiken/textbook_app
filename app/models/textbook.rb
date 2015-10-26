class Textbook < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :course
  has_many :comments, dependent: :destroy

  mount_uploader :image, TextbookImageUploader

  # will paginate gem. A number of textbooks per page.
  self.per_page = 3

  validates :title, presence: true, length: { maximum: 70 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01, less_than: 1000 } 
  validates :subject_id, presence: true
  validates :course_id, presence: true

  default_scope -> { order(created_at: :desc) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PgSearch
  pg_search_scope :search_by_title_and_description, against: { :title => 'A', :description => 'B' }, 
                  using: { tsearch: { dictionary: "english"} },
                  associated_against: { user: :name, course: :name }

  # Replaced by pg_search. leave this for reference to postgres full text search.
  #scope :search, ->(search) { where("title @@ :search OR description @@ :search", search: search) }


  # Returns all users left a comment on this textbook listing.
  def commenters
    commenters = []
    comments.each do |comment|
      commenters << comment.user unless commenters.include?(comment.user)
    end
    commenters
  end

end
