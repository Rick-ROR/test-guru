class Test < ApplicationRecord
  def self.tests_category_sort_by_desc(category)
    Test.where(category_id: category.id).order(title: :desc).pluck(:title)
  end
end
