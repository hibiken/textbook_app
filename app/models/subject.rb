class Subject < ActiveRecord::Base
  has_many :textbooks, dependent: :destroy

  validates :name, presence: true

  default_scope -> { order(:name) }
end
