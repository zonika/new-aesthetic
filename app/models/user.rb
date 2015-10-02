class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :works

  include PgSearch

  has_many :curator_works, :foreign_key => "curator_id"
  has_many :pieces, through: :curator_works, :class_name => "Work"
  
  def index
    @users = User.all
  end

  # def self.search(query)
  #   @query = query.capitalize
  #   if (User.find_by(first_name: "#{@query}")) || (User.find_by(last_name: "#{@query}"))
  #     [(User.find_by(first_name: "#{@query}")) || (User.find_by(last_name: "#{@query}"))]
  #   else
  #     (User.where("first_name LIKE ?", "%#{@query}%")) ||  (User.where("last_name LIKE ?", "%#{@query}%"))
  #   end
  # end

  def self.random_user
    User.where(artist: true).where.not(masterpiece: nil).sample
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
