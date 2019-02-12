class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :likes
  has_many :reverses_of_like, class_name: 'Like', foreign_key: 'micropost_id'
end
