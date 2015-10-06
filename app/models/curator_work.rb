class CuratorWork < ActiveRecord::Base
  belongs_to :curator, :class_name => "User"
  belongs_to :piece, :class_name => "Work"

  after_create :increase_times_collected
  after_destroy :decrease_times_collected

  def increase_times_collected
    piece.times_collected += 1
    piece.save
  end

  def decrease_times_collected
    piece.times_collected -= 1
    piece.save
  end
end
