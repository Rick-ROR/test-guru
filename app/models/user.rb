class User < ApplicationRecord
  has_many :history_tests
  has_many :tests, through: :history_tests
  has_many :author_tests, foreign_key: 'author_id', class_name: 'Test'

  def tests_at_level(level)
    Test.joins(:history_tests).where(level: level, history_tests: { user_id: id })
  end
end
