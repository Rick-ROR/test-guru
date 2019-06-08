class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :history_tests
  has_many :users, through: :history_tests
  belongs_to :author, class_name: 'User'
  has_many :user_badges

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }

  scope :by_level, -> (level) { where(level: level) }
  scope :simple, -> { by_level(0..1) }
  scope :middle, -> { by_level(2..4) }
  scope :complex, -> { by_level(5..Float::INFINITY) }

  scope :get_by_category, -> (title) { Test.joins(:category).where(categories: { title: title }) }


  def self.find_by_category(title)
    get_by_category(title).order(title: :desc).pluck(:title)
  end
end
