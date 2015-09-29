class WorkTag < ActiveRecord::Base
  belongs_to :tag_id
  belongs_to :work_id
end
