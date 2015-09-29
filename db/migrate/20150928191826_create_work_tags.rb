class CreateWorkTags < ActiveRecord::Migration
  def change
    create_table :work_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :work, index: true

      t.timestamps null: false
    end
    add_foreign_key :work_tags, :tags
    add_foreign_key :work_tags, :works
  end
end
