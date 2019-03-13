class User < ApplicationRecord
  has_many :test_histories

  def tests_at_level(level)
    Test.joins(:test_histories).where(level: level)
  end
end
