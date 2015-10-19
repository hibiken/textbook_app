class Subject < ActiveRecord::Base
  has_many :textbooks, dependent: :destroy

  validates :name, presence: true


  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope -> { order(:name) }
end
