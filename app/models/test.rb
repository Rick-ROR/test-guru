class Test < ApplicationRecord
  belongs_to :category
  has_many :question
  has_many :history_tests
  has_many :users, through: :history_tests
  belongs_to :author, class_name: 'User'

  def self.find_by_category(title)
    Test.joins(:category).where(categories: { title: title }).order(title: :desc).pluck(:title)
  end
end
