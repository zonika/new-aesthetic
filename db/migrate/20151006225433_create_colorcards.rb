class CreateColorcards < ActiveRecord::Migration
  def change
    create_table :colorcards do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
