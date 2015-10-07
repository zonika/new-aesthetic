class AddTimesCollectedToWorks < ActiveRecord::Migration
  def change
    add_column :works, :times_collected, :integer, default: 0
  end
end
