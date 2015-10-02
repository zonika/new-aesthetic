class RecreateCuratorWorks < ActiveRecord::Migration
  def change
    create_table :curator_works do |t|
      t.belongs_to :curator, index: true
      t.belongs_to :work, index: true
    end
  end
end
