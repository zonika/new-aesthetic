class AddColumnsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :artist, :boolean
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

  end
end
