class AddMasterpieceColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :masterpiece, :integer
  end
end
