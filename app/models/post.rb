class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many_attached :portraits

  validates :title, presence: true, length: { maximum: 20 }
  validates :subject, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  
end
