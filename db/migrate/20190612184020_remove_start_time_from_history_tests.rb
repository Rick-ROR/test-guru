class RemoveStartTimeFromHistoryTests < ActiveRecord::Migration[5.2]
  def change
    remove_column :history_tests, :start_time, :datetime
  end
end
