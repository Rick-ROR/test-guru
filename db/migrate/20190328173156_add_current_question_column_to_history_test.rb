class AddCurrentQuestionColumnToHistoryTest < ActiveRecord::Migration[5.2]
  def change
    add_column :history_tests, :correct_questions, :integer, default: 0
    add_reference :history_tests, :current_question, foreign_key: { to_table: :questions }
  end
end
