class AddTestRefToUserBadge < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_badges, :test, foreign_key: true
    add_column :badges, :rule, :string
  end
end
