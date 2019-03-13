class Test < ApplicationRecord
  belongs_to :category
  has_many :test_histories

  def self.find_by_category(title)
    Test.joins(:category).where(categories: { title: title }).order(title: :desc).pluck(:title)
  end
end
