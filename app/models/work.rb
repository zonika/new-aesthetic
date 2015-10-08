class Work < ActiveRecord::Base
  belongs_to :user, :foreign_key => "artist_id"

  has_many :curator_works, :foreign_key => "piece_id"
  has_many :curators, through: :curator_works

  has_many :work_colorcards
  has_many :colorcards, through: :work_colorcards

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>"}
  validates :name, presence:true
  validates :image, presence:true
  validates_attachment_content_type :image, content_type: /\image\/.*\Z/
  acts_as_taggable

  before_destroy :destroy_relations

  include PgSearch
  multisearchable :against => [:name, :tag_list]

  def parse_colors(colors)
    hues = colors.collect do |hue|
      hue = ColorMath::hex_color(hue)
      if hue.saturation*100 > 15
        if hue.luminance*100 > 7 && hue.luminance*100 < 90
          if hue.hue >= 0 && hue.hue < 15
            "red"
          elsif hue.hue >= 15 && hue.hue < 40
            'orange'
          elsif hue.hue >= 40 && hue.hue < 70
            'yellow'
          elsif hue.hue >= 70 && hue.hue < 160
            'green'
          elsif hue.hue >= 160 && hue.hue < 250
            'blue'
          elsif hue.hue >= 250 && hue.hue < 290
            'purple'
          elsif hue.hue >= 290 && hue.hue <= 360
            'red'
          end
        elsif hue.luminance*100 <= 7
          'black'
        elsif hue.luminance*100 >= 90
          'white'
        end
      else
        if hue.luminance*100 <= 50
          'black'
        elsif hue.luminance*100 > 50
          'white'
        end
      end
    end
    hues.uniq!
    i = 1
    hues.each do |hue|
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
