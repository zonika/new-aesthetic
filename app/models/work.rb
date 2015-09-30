class Work < ActiveRecord::Base
  belongs_to :user, :foreign_key => "artist_id"
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>"}
  validates_attachment_content_type :image, content_type: /\image\/.*\Z/

end
