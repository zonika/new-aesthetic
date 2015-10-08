class WorkColorcard < ActiveRecord::Base
  belongs_to :colorcard
  belongs_to :work
end
