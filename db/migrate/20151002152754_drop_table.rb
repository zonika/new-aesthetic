class DropTable < ActiveRecord::Migration
  def change
    drop_table :curator_works
  end
end
