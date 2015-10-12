class Textbook < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 70 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000 } 
end
