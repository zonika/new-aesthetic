class Work < ActiveRecord::Base
  belongs_to :user, :foreign_key => "artist_id"

  has_many :curator_works, :foreign_key => "piece_id"
  has_many :curators, through: :curator_works

  has_many :work_colorcards
  has_many :colorcards, through: :work_colorcards

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>"}
  validates_attachment_content_type :image, content_type: /\image\/.*\Z/
  validates :name, presence:true
  acts_as_taggable

  before_destroy :destroy_relations

  include PgSearch
  multisearchable :against => [:name, :tag_list]


  # 100% light is white for any hue
  # 0% light is black for any hue
  # 0% saturation is a shade of gray for any hue
  def parse_colors(colors)
    hues = colors.collect do |co|
      hue = ColorMath::hex_color(co).hue.to_i
      if hue >= 0 && hue < 30
        "red"
      elsif hue >= 30 && hue < 60
        'orange'
      elsif hue >= 60 && hue < 90
        'yellow'
      elsif hue >= 90 && hue < 180
        'green'
      elsif hue >= 180 && hue < 270
        'blue'
      elsif hue >= 270 && hue < 330
        'purple'
      elsif hue >= 330 && hue <= 360
        'pink'
      end
    end
    hues.uniq!
    i = 1
    hues.each do |hue|
      binding.pry
      c = Colorcard.find_by(name: hue)
      WorkColorcard.create(work_id:id,colorcard_id:c.id,rank:i)
      i+=1
    end
  end

  def destroy_relations
    wcc = WorkColorcard.where(work_id: id)
    wcc.each do |card|
      card.destroy
    end
  end

end
