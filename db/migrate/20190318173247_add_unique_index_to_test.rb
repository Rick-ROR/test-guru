class AddUniqueIndexToTest < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string, default: 'example@example.edu'
    add_index :tests, [:title, :level], unique: true
  end
end
