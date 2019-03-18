class User < ApplicationRecord
  has_many :history_tests
  has_many :tests, through: :history_tests
  has_many :author_tests, foreign_key: 'author_id', class_name: 'Test'

  validates :name, :email, presence: true

  def tests_by_level(level)
    tests.by_level(level)
  end
end
