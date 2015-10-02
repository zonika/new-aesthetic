class CuratorWork < ActiveRecord::Base
  belongs_to :curator, :class_name => "User"
  belongs_to :piece, :class_name => "Work"
end
