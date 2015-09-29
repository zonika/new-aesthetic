class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :img_url
      t.string :medium
      t.string :type
      t.timestamps null: false
    end
    add_foreign_key :works, :users
  end
end
