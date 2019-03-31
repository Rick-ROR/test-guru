class User < ApplicationRecord

  # include Auth

  has_many :history_tests
  has_many :tests, through: :history_tests
  has_many :author_tests, foreign_key: 'author_id', class_name: 'Test'

  validates :name, :name, presence: true
  validates :name, :email, presence: true

  has_secure_password

  def tests_by_level(level)
    tests.by_level(level)
  end

  def test_passage(test)
    history_tests.order(id: :desc).find_by(test_id: test.id)
  end
end
