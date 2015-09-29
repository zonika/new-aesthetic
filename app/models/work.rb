class Work < ActiveRecord::Base
  belongs_to :user, :foreign_key => "artist_id"
end
