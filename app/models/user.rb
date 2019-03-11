class User < ApplicationRecord
  def tests_at_level(level)
    tests.where(level: level)
  end
end
