class Colorcard < ActiveRecord::Base
  has_many :work_colorcards
  has_many :works, through: :work_colorcards
end
