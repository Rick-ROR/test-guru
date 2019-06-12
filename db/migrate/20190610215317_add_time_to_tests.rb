class AddTimeToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :time, :integer, default: 0
    add_column :history_tests, :timeout, :datetime
  end
end
