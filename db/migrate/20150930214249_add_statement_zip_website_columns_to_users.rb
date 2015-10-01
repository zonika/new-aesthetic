class AddStatementZipWebsiteColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :artist_statement, :text
    add_column :users, :zip, :integer
    add_column :users, :website, :string
  end
end
