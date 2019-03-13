class ChangeTestHistoryToHistoryTest < ActiveRecord::Migration[5.2]
  def change
    rename_table :test_histories, :history_tests
  end
end
