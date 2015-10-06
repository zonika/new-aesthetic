class CreateWorkColorcards < ActiveRecord::Migration
  def change
    create_table :work_colorcards do |t|
      t.belongs_to :colorcard, index: true
      t.belongs_to :work, index: true
      t.integer :rank

      t.timestamps null: false
    end
    add_foreign_key :work_colorcards, :colorcards
    add_foreign_key :work_colorcards, :works
  end
end
