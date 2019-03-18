class User < ApplicationRecord
  has_many :history_tests
  has_many :tests, through: :history_tests
  has_many :author_tests, foreign_key: 'author_id', class_name: 'Test'

  validates :name, :email, presence: true

  scope :get_tests, -> { Test.joins(:history_tests) }

  def tests_by_level(level)
    get_tests.by_level(level).where(history_tests: { user_id: id })
  end
end
