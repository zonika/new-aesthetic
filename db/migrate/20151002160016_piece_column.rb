class PieceColumn < ActiveRecord::Migration
  def change
    remove_column :curator_works, :work_id

    add_column :curator_works, :piece_id, :integer
  end
end
