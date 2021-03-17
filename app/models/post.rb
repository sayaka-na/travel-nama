class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many_attached :portraits

  validates :title, presence: true, length: { maximum: 10 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :portraits, presence: true

  has_many :favorites, dependent: :destroy
  has_many :likers, through: :favorites, source: :user

end
