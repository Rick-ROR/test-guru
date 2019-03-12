class Test < ApplicationRecord
  def self.tests_category_sort_by_desc(category_title)
    Test.joins("JOIN categories ON tests.category_id = categories.id AND categories.title = :title", title: category_title).order(title: :desc).pluck(:title)
  end
end
