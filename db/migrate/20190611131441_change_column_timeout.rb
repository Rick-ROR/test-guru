class ChangeColumnTimeout < ActiveRecord::Migration[5.2]
  def change
    rename_column :history_tests, :timeout, :start_time
  end
end
