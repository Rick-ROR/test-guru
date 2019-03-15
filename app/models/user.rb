class User < ApplicationRecord
  has_many :history_tests

  def tests_at_level(level)
    Test.joins(:history_tests).where(level: level, history_tests: { user_id: id })
  end
end
