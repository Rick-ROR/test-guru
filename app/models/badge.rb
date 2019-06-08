class Badge < ApplicationRecord

  has_many :user_badges
  has_many :users, through: :user_badges

  validates :image, :title, presence: true

  LIST_RULES = ['All on Level', 'All in Category', 'Pass from the First Time']

end
