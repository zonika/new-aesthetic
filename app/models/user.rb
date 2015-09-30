class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :works
  has_many :work_tags, through: :works
  has_many :tags, through: :work_tags

  def self.search(query)
    @query = query.capitalize
    if (User.find_by(first_name: "#{@query}")) || (User.find_by(last_name: "#{@query}"))
     [(User.find_by(first_name: "#{@query}")) || (User.find_by(last_name: "#{@query}"))]
    else
     (User.where("first_name LIKE ?", "%#{@query}%")) ||  (User.where("last_name LIKE ?", "%#{@query}%"))
    end
  end

end
